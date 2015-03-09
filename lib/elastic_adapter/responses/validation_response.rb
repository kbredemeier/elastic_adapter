module ElasticAdapter
  module Responses
    class ValidationResponse < BaseResponse
      attr_reader :explanations, :valid

      def valid?
        valid
      end

      private

      def set_instance_variables
        @valid = object[:valid]
        @explanations = object[:explanations]
      end
    end
  end
end
