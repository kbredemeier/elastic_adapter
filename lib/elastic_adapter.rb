require "elastic_adapter/version"
require "elastic_adapter/repository"

begin
  require "pry"
rescue LoadError
end

module ElasticAdapter
  class << self
    def configure

    end
  end
end
