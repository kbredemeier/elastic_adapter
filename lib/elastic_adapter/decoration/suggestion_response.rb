module ElasticAdapter
  module Decoration
    class SuggestionResponse < Decorator

      attr_reader :count

      # Builds a Hash with a smaller interface from the
      # decorated response
      #
      # @param [Hash] hash
      # @return [Hash]
      def sanitize_hash(hash)
        new_hash = {}
        new_hash[:options] = hash[hash.keys[1]].first[:options]
        new_hash
      end

      def count
        @count ||= self[:options].length
      end
    end
  end
end
