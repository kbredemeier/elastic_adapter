module ElasticAdapter
  module Decoration
    class ResponseDecoratorFactory
      class << self
        def decorate(response)
          if response.key? :source
            return GetResponse.new(response)
          end

          response
        end
      end
    end
  end
end
