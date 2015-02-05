module ElasticAdapter
  module Decoration
    class ResponseDecoratorFactory
      class << self
        def decorate(response)
          if response.key? :acknowledged
          elsif response.key? :created
          elsif response.key? :exception
          elsif response.key? :count
            return CountResponse.new(response)
          elsif response.key? :source
            return HitDecorator.new(response)
          elsif response.key? :hits
            return SearchResponse.new(response)
          elsif response.key? :valid
            return ValidationResponse.new(response)
          else
            return SuggestionResponse.new(response)
          end

          response
        end
      end
    end
  end
end
