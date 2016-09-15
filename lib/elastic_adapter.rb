require "elasticsearch"

require "elastic_adapter/version"
require "elastic_adapter/document_type"
require "elastic_adapter/index"

begin
  require "pry"
rescue LoadError
end

module ElasticAdapter
end
