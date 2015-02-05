module ElasticAdapter
  module Decoration
    # Used to decorate responses from the elasticsearch suggestion api
    # @attr_reader [Integer] count the amount of suggestions
    class SuggestionResponse < Decorator

      attr_reader :count

      # Builds a Hash with a smaller interface from the
      # decorated response
      #
      # @param [Hash] hash
      # @return [Hash]
      def alter_object(hash)
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
