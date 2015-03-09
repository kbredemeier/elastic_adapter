require "elasticsearch"

require "elastic_adapter/version"
require "elastic_adapter/document_type"

require "elastic_adapter/responses/base_response"
require "elastic_adapter/responses/sanitized_response"
require "elastic_adapter/responses/aggregation_response"
require "elastic_adapter/responses/count_response"
require "elastic_adapter/responses/get_response"
require "elastic_adapter/responses/search_response"
require "elastic_adapter/responses/suggestion_response"
require "elastic_adapter/responses/validation_response"
require "elastic_adapter/responses/response_decorator_factory"

require "elastic_adapter/index"

begin
  require "pry"
rescue LoadError
end

module ElasticAdapter
end
