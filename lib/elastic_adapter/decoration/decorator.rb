require "delegate"

module ElasticAdapter
  module Decoration
    # Abstract base class for response decorators
    # @abstract
    #
    # @attr [Object] original_object the original unmodified object
    class Decorator < SimpleDelegator
      attr_reader :original_object

      # Takes an object and stores it in `@original_object` and saves a
      # altered version as the decorated object
      #
      # @param [Object] object
      def initialize(object)
        @original_object = object
        __setobj__(alter_object(object))
      end

      # Returns the underlaying altered object
      #
      # @return [Object] the altered object
      def object
        __getobj__
      end

      # Is intended to alter the passed object to change it's interface
      #
      # @param [Object] object
      # @return [Object]
      def alter_object(_object)
        fail NotImplementedError, "alter_object must be overriden in subclasses"
      end
    end
  end
end
