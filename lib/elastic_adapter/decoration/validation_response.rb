module ElasticAdapter
  module Decoration
    class ValidationResponse < Decorator

      # Builds a Hash with a smaller interface from the
      # decorated response
      #
      # @param [Hash] hash
      # @return [Hash]
      def alter_object(hash)
        hash[:valid]
      end

      # def valid?
      #   self[:valid]
      # end
      #
      # def invalid?
      #   !valid?
      # end

    end
  end
end
