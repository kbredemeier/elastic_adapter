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
      response = handle_api_call do
        client.count index: name, body: query
      end

      response.fetch("count", 0)
    end

    def index(document)
      doc = document.to_hash.merge({})

      params = {
        index: name,
        id: doc.delete(:id),
        type: document_type.name,
        body: doc
      }

      res = handle_api_call do
        client.index(params)
      end
    end

    private

    def handle_api_call
      begin
        Response.new(yield)
      rescue Elasticsearch::Transport::Transport::Error => e
        Response.new(
          exception: e
        )
      end
    end
  end
end
