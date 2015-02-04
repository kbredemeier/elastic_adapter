require "elasticsearch/transport"
require "elasticsearch/api"

require "elastic_adapter/version"
require "elastic_adapter/attribute_accessor"
require "elastic_adapter/configuration"
require "elastic_adapter/response"
require "elastic_adapter/index"

begin
  require "pry"
rescue LoadError
end

module ElasticAdapter
end
