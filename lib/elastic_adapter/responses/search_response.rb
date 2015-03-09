module ElasticAdapter
  module Responses
    class SearchResponse < BaseResponse
      attr_reader :hits

      private

      def set_instance_variables
        hits = []
        object[:hits][:hits].each do |hit|
          hits << {
            id: hit[:id]
          }.merge(hit[:source])

        end

        @hits = hits
      end
    end
  end
end
