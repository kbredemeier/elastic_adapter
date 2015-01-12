require "elasticsearch/transport"
require "elasticsearch/api"

require "elastic_adapter/version"
require "elastic_adapter/attribute_accessor"
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

    # This method's primary purpose is to reset the
    # Configufation in tests
    def reset
      @configuration = Configuration.new
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
