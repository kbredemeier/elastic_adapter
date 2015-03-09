module ElasticAdapter
  module Decoration
    # Used to decorate responses from the elasticsearch search api
    #
    # @attr_reader [Hash] aggregations
    class AggregationResponse < Decorator
      attr_reader :aggregations

      # Reduces the interface
      #
      # @param [Hash] hash
      # @return [Hash]
      def alter_object(hash)
        new_hash = {}
        new_hash[:aggregations] = {}

        hash[:aggregations].each do |key, value|
          new_hash[:aggregations][key] = []

          value[:buckets].each do |agg|
            new_hash[:aggregations][key] << {
              term: agg[:key],
              count: agg[:doc_count]
            }
          end
        end

        @aggregations = new_hash[:aggregations]

        new_hash
      end
    end
  end
end
