module ElasticAdapter
  module Responses
    module WithException
      def exception
        object.fetch(:exception)
      end
    end
  end
end
