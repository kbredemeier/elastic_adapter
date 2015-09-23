module ElasticAdapter
  module Responses
    module WithHit
      class Hit < SimpleDelegator
        attr_reader :version

        def initialize(response)
          response = response.dup
          @found = response.delete(:found)
          @version = response.delete(:version)
          __setobj__(response)
        end

        def found?
          @found
        end
      end

      def hit
        @hit ||= Hit.new(object)
      end
    end
  end
end
