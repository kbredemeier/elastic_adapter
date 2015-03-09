require "delegate"

module ElasticAdapter
  module Responses
    class BaseResponse < SimpleDelegator
      def initialize(object)
        __setobj__(object)
        set_instance_variables
      end

      # Returns the underlaying object
      #
      # @return [Object] The underlaying object
      def object
        __getobj__
      end

      private

      # This method is intended to set instance variables that provide
      # access to values from the original object
      #
      # @param [Object] object
      def set_instance_variables
      end
    end
  end
end
