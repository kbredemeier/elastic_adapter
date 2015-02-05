module ElasticAdapter
  module Decoration
    # Used to decorate responses from the elasticsearch search api
    #
    # @attr_reader [Integer] count the total amount of search results
    class SearchResponse < Decorator

      attr_reader :count

      # Reduces the interface and assigns the @count variable
      #
      # @param [Hash] hash
      # @return [Hash]
      def alter_object(hash)
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
