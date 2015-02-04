module ElasticAdapter
  # This class encapsulates the access to an elasticsearch index
  class Index
    attr_reader :config
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
