module ElasticAdapter
  module Responses
    class CountResponse < BaseResponse
      attr_reader :count

      private

      def set_instance_variables
        @count = object[:count]
      end
    end
  end
end
