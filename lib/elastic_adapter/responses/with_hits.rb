module ElasticAdapter
  module Responses
    module WithHits
      class Hits < SimpleDelegator
        attr_reader :count

        def initialize(response)
          @count = response.fetch(:hits, {}).fetch(:total, 0)
          __setobj__(response.fetch(:hits, {}).fetch(:hits, []))
        end
      end

      def hits
        @hits ||= Hits.new(object)
      end
    end
  end
end
