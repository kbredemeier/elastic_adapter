module ElasticAdapter
  module Decoration
    class Decorator < SimpleDelegator
      def object
        __getobj__
      end

      class << self
        def decorate(collection)
          collection = Array(collection)
          collection.map { |i| new i }
        end
      end
    end
  end
end
