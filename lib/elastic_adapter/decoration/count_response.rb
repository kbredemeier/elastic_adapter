module ElasticAdapter
  module Decoration
    # Used to wrap responses from the elasticsearch count api
    # After decoration the decorator will point to the actual
    # count returned by elasticsearch
    class CountResponse < Decorator

      # Reduced the hash to the count returned by elasticsearch
      #
      # @param [Object] object
      # @return [Integer] the count returned by elasticsearch
      def alter_object(object)
        object[:count]
      end

    end
  end
end
