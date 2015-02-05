module ElasticAdapter
  module Decoration
    # Used to decorate responses from the elasticsearch get api or
    # to decorate single hits returned from the elasticsearch
    # search api
    #
    # @see ResponseDecoratorFactory
    # @see SearchResponse#alter_object
    class HitDecorator < Decorator
      # Reduces the interface of a single hit
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
