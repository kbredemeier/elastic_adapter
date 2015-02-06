module ElasticAdapter
  module Decoration
    # Used to decorate responses from the elasticseach suggest api.
    # Delegates to a Boolean
    class ValidationResponse < Decorator
      # Returns the validation status from the original hash
      #
      # @param [Hash] hash
      # @return [Hash]
      def alter_object(hash)
        hash[:valid]
      end
    end
  end
end
