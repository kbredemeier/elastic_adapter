module ElasticAdapter
  module Decoration
    class ResponseDecoratorFactory
      class << self
        def decorate(response)
          if response.key? :source
            return HitDecorator.new(response)
          elsif response.key? :hits
            return SearchResponse.new(response)
          end

          response
        end
      end
    end
  end
end
