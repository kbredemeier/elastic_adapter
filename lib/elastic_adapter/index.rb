module ElasticAdapter
  # This class encapsulates the access to an elasticsearch index
  class Index
    attr_reader :name, :settings, :document_type, :url, :log, :client

    def initialize(params)
      @name = params.fetch(:name)
      @settings = params.fetch(:settings)
      @document_type = params.fetch(:document_type)
      @url = params.fetch(:url)
      @log = params.fetch(:log)
      @client = params.fetch(:client, Elasticsearch::Client.new(url: url, log: log))

      self
    end

    def create_index
      handle_api_call do
        client.indices.create(
          index: name,
          body: {
            mappings: document_type.mappings,
            settings: settings
          }
        )
      end
    end

    def delete_index
      handle_api_call do
        client.indices.delete index: name
      end
    end

    def count(query = {query:{match_all: {}}})
      handle_api_call do
        client.count index: name, body: query
      end.fetch(:count, 0)
    end

    def index(document)
      doc = document.to_hash.merge({})

      params = {
        index: name,
        id: doc.delete(:id),
        type: document_type.name,
        body: doc
      }

      response = handle_api_call do
        client.index(params)
      end

      response
    end

    def get(id)
      handle_api_call do
        client.get(
          index: name,
          type: document_type.name,
          id: id
        )
      end
    end

    def search(query)
      handle_api_call do
        client.search(
          index: name,
          body: query
        )
      end
    end

    def suggest(query)
      handle_api_call do
        client.suggest(
          index: name,
          body: query
        )
      end
    end

    private

    def handle_api_call
      begin
        Response.new(yield).decorate
      rescue Elasticsearch::Transport::Transport::Error => e
        Response.new(
          exception: e
        )
      end
    end
  end
end
