require "elasticsearch"

require "elastic_adapter/version"
require "elastic_adapter/document_type"
require "elastic_adapter/response"

require "elastic_adapter/responses/with_exception"
require "elastic_adapter/responses/with_aggregations"
require "elastic_adapter/responses/with_validations"
require "elastic_adapter/responses/with_suggestions"
require "elastic_adapter/responses/with_hits"
require "elastic_adapter/responses/with_hit"
require "elastic_adapter/responses/with_count"

require "elastic_adapter/index"

begin
  require "pry"
rescue LoadError
end

module ElasticAdapter
end
