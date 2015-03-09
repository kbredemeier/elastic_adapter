module ElasticAdapter
  module Responses
    class SanitizedResponse < BaseResponse
      def initialize(object)
        super(deep_sanitize_object(object))
      end

      private

      def deep_sanitize_object(object)
        if object.is_a? Hash
          return sanitize_hash(object)
        elsif object.is_a? Array
          return sanitize_array(object)
        else
          return object
        end
      end

      def sanitize_hash(hash)
        result = {}

        hash.each do |key, value|
          new_key = remove_leading_underscore(key).to_sym

          if value.is_a?(Hash)
            result[new_key] = sanitize_hash(value)
          else
            result[new_key] = deep_sanitize_object(value)
          end
        end

        result
      end

      def sanitize_array(array)
        array.map { |element| deep_sanitize_object(element) }
      end

      def remove_leading_underscore(string)
        /^_?(.*)$/.match(string)[1]
      end
    end
  end
end

