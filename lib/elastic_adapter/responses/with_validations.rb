module ElasticAdapter
  module Responses
    module WithValidations
      def explanations
        object.fetch(:explanations, [])
      end

      def valid?
        object[:valid]
      end
    end
  end
end
