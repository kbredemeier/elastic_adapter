module ElasticAdapter
  module Responses
    module WithAggregations
      def aggregations
        object.fetch(:aggregations, {})
      end
    end
  end
end
