module ElasticAdapter
  module Decoration
    class CountResponse < Decorator

      attr_reader :count

      # Builds a Hash with a smaller interface from the
      # decorated response
      #
      # @param [Hash] hash
      # @return [Hash]
      def sanitize_hash(hash)
        new_hash = {}
        new_hash[:count] = hash[:count]
        @count = new_hash[:count]
        new_hash
      end

    end
  end
end
