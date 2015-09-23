module ElasticAdapter
  module Responses
    module WithCount
      def count
        object.fetch(:count, 0)
      end
    end
  end
end
