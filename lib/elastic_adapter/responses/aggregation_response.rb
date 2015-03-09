module ElasticAdapter
  module Responses
    class AggregationResponse < BaseResponse
      attr_reader :aggregations

      private

      def set_instance_variables
        new_hash = {}

        new_hash[:aggregations] = {}

        object[:aggregations].each do |key, value|
          new_hash[:aggregations][key] = []

          value[:buckets].each do |agg|
            new_hash[:aggregations][key] << {
              term: agg[:key],
              count: agg[:doc_count]
            }
          end
        end

        @aggregations = new_hash[:aggregations]
      end
    end
  end
end
