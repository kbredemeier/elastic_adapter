module ElasticAdapter
  module Decoration
    class SearchResponse < Decorator

      attr_reader :count

      # Builds a Hash with a smaller interface from the
      # decorated response
      #
      # @param [Hash] hash
      # @return [Hash]
      def sanitize_hash(hash)
        new_hash = {}
        new_hash[:count] = hash[:hits][:total]
        @count = new_hash[:count]
        new_hash[:hits] = []

        hash[:hits][:hits].each do |hit|
          new_hash[:hits] << HitDecorator.new(hit)
        end

        new_hash
      end

    end
  end
end
