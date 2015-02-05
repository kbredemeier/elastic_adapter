module ElasticAdapter
  module Decoration
    class HitDecorator < Decorator
      # Builds a Hash with a smaller interface from the
      # decorated response
      #
      # @param [Hash] hash
      # @return [Hash]
      def alter_object(hash)
        new_hash = {}
        new_hash[:id] = hash[:id]
        hash[:source].each do |key, value|
          new_hash[key] = value
        end

        new_hash
      end
    end
  end
end
