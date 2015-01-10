require "elastic_adapter/version"
require "elastic_adapter/configuration"
require "elastic_adapter/repository"

begin
  require "pry"
rescue LoadError
end

module ElasticAdapter
  class << self
    attr_writer :configuration

    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
