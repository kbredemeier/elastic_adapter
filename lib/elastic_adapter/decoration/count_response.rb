module ElasticAdapter
  module Decoration
    class CountResponse < Decorator

      attr_reader :count

      # Builds a Hash with a smaller interface from the
      # decorated response
      #
      # @param [Hash] hash
      # @return [Hash]
      def alter_object(hash)
        hash[:count]
      end

    end
  end
end
