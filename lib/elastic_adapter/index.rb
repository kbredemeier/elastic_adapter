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
  end
end
