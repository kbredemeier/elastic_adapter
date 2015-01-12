module ElasticAdapter
  # This class encapsulates the access to an elasticsearch index
  class Repository
    def initialize(config)
      @config = config
    end

    private

    def host
      config.url
    end

    def log
      config.log
    end
  end
end
