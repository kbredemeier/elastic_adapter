module ElasticAdapter
  module Responses
    class GetResponse < BaseResponse
      attr_reader :document

      private

      def set_instance_variables
        @document = object[:source].merge(id: object[:id])
      end
    end
  end
end
