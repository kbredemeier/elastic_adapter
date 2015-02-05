require "delegate"

module ElasticAdapter
  module Decoration
    class Decorator < SimpleDelegator

      attr_reader :original_object

      # Takes a hash turns it's keys into hashes, removes leading
      # underscores and stores the original hash.
      #
      # @param [Hash] hash
      def initialize(hash)
        @original_object = hash
        __setobj__(alter_object(hash))
      end

      # Returns the underlaying sanitized hash
      #
      # @return [Object] the decorated object
      def object
        __getobj__
      end

      # Is intended to perform sanitization on the passed hash
      #
      # @param [Hash] hash
      # @return [Hash]
      def alter_object(hash)
        fail NotImplementedError, "alter_object must be overriden in subclasses!"
      end

    end
  end
end
