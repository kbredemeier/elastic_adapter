module ElasticAdapter
  module Responses
    module WithSuggestions
      def suggestions
        object.fetch(:suggest, {})
      end
    end
  end
end
