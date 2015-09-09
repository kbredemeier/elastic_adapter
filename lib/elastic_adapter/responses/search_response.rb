module ElasticAdapter
  module Responses
    class SearchResponse < BaseResponse
      attr_reader :hits, :aggregations, :suggestions

      private

      def set_instance_variables
        @hits = collect_hits
        @aggregations = collect_aggregations
        @suggestions = collect_suggestions
      end

      def collect_hits
        return [] unless object[:hits]
        object[:hits][:hits].map { |hit| { id: hit[:id] }.merge(hit[:source]) }
      end

      def collect_aggregations
        return [] unless object[:aggregations]
        aggs = {}
        object[:aggregations].each do |agg_name, result|
          aggs[agg_name] = []
          result[:buckets].each do |agg|
            aggs[agg_name] << { term: agg[:key], count: agg[:doc_count] }
          end
        end
        aggs
      end

      def collect_suggestions
        return [] unless object[:suggest]
        object[:suggest].map { |suggestion_name, content|
          # In this context key is the named suggestion
          # returned by elasticsearch
          SuggestionResponse::Suggestion.new(suggestion_name, content)
        }
      end
    end
  end
end
