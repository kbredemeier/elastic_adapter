module ElasticAdapter
  # This class encapsulates the access to a Elasticsearch::Transport::Client
  # and provides an implementation of the repository pattern
  #
  # @attr_reader [String] name the name of the index
  # @attr_reader [Hash] settings the index settings
  # @attr_reader [DocumentType] document_type a DocumentType
  #   with the document name and it's mappings
  # @attr_reader [String] url the url to elasticsearch
  # @attr_reader [Boolean] log print degub log to $stdout
  # @attr_reader [Client] client the client who
  #   handles the communication with elasticsearch
  #
  # @example Initialization
  #   index = ElasticAdapter::Index.new(
  #     name: "test_index",
  #     settings: { number_of_shards: 1 },
  #     document_type: ElasticAdapter::DocumentType.new("test_doc", mappings: {
  #         test_doc: {
  #           properties: {
  #             foo: { type: "string" }
  #           }
  #         }
  #       }
  #     ),
  #     url: "localhost:9200",
  #     log: true
  #   )
  class Index
    attr_reader :name, :settings, :document_type, :url, :log, :client

    # @param [Hash] params
    # @option params [String] :name required
    # @option params [Hash] :settings required
    # @option params [DocumentType] :document_type required
    # @option params [String] :url required
    # @option params [Boolean] :log required
    # @option params [Client] client optional: A client. Defaults to
    #   Elasticsearch#Transport#Client
    def initialize(params)
      @name = params.fetch(:name)
      @settings = params.fetch(:settings)
      @document_type = params.fetch(:document_type)
      @url = params.fetch(:url)
      @log = params.fetch(:log)
      @client = params.fetch :client do
        Elasticsearch::Client.new(url: url, log: log)
      end

      self
    end

    # Creates the index with it's settings and mappings
    #
    # @see http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/indices-create-index.html Elasticsearch create index
    #
    # @return [Hash]
    def create_index
      client.indices.create(
        index: name,
        body: {
          mappings: document_type.mappings,
          settings: settings
        }
      )
    end

    # Deletes the index
    #
    # @see http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/indices-delete-index.html Elasticsearch delete index
    #
    # @return [Hash]
    def delete_index
      client.indices.delete index: name
    end

    # Returns the document count for the index
    #
    # @see http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search-count.html#search-count Elasticsearch count api
    #
    # @param [Hash] query a query to count the documents for a given query. Defaults to match all
    # @return [Hash] the count
    def count(query = { query: { match_all: {} } })
      client.count index: name, body: query
    end

    # Indexes a Hash or anything that responds to to_hash as a document
    # in the index
    #
    # @see http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/docs-index_.html Elasticsearch index api
    #
    # @example
    #   test_index = ElasticAdapter::Index.new(...)
    #   test_index.index(id: 1, name: "foo")
    #
    # @param [Hash] document
    # @return [Hash]
    def index(document)
      doc = document.to_hash.merge({})

      params = {
        index: name,
        id: doc.delete(:id),
        type: document_type.name,
        body: doc
      }

      client.index(params)
    end

    # Returns the document with the given id from the index
    #
    # @see http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/docs-get.html Elasticsearch get api
    #
    # @param [Integer] id
    # @return [ElasticAdapter::HitDecorator]
    def get(id)
      client.get(
        index: name,
        type: document_type.name,
        id: id
      )
    end

    # Searches the index for documents matching the passed query.
    #
    # @see http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search.html Elasticsearch search apis
    #
    # @example
    #   test_index = ElasticAdatper::Index.new(...)
    #   test_index.seach(query: {match: {foo: "bar"}})
    #
    # @param [Hash] query
    # @return [Hash]
    def search(query)
      client.search(
        index: name,
        body: query
      )
    end

    # Searches the index for suggestions for the passed suggest query
    #
    # @see http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search-suggesters.html Elasticsearch suggesters
    #
    # @example
    #   test_index = ElasticAdatper::Index.new(...)
    #   test_index.seach(name_suggestions: {text: "foo", completion: {field: "name"}})
    #
    # @param [Hash] query
    # @return [Hash]
    def suggest(query)
      client.suggest(
        index: name,
        body: query
      )
    end

    # Validates the passed query
    #
    # @see http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search-validate.html Elasticsearch validate api
    #
    # @param [Hash] query
    # @return [Hash]
    def validate(query)
      client.indices.validate_query(
        index: name,
        explain: true,
        body: query
      )
    end

    # Executes a search request and returns the response
    #
    # @param [Hash] query
    # @return [Hash]
    def aggregate(query)
      client.search(
        index: name,
        body: query
      )
    end
  end
end
