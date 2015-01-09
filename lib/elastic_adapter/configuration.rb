module ElasticAdapter
  class Configuration
    attr_accessor :log, :url

    def initialize(options = {})
      @log = options.fetch(:log, true)
      @url = options.fetch(:url, "http://localhost:9200")
    end

  end
end
