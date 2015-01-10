module ElasticAdapter
  # This class encapsulates the access to an elasticsearch index
  class Repository
    attr_accessor :config, :url, :log

    def initialize(config = {})
      @config = config
      @url = config.fetch(:url, ElasticAdapter.configuration.url)
      @log = config.fetch(:log, ElasticAdapter.configuration.log)
    end

  end
end
