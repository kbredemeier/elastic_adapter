require "elasticsearch"

require "elastic_adapter/version"
require "elastic_adapter/document_type"
require "elastic_adapter/decoration/decorator"
require "elastic_adapter/decoration/hit_decorator"
require "elastic_adapter/decoration/count_response"
require "elastic_adapter/decoration/validation_response"
require "elastic_adapter/decoration/suggestion_response"
require "elastic_adapter/decoration/search_response"
require "elastic_adapter/decoration/response_decorator_factory"
require "elastic_adapter/response"
require "elastic_adapter/index"

begin
  require "pry"
rescue LoadError
end

module ElasticAdapter
end
