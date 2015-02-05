module ElasticAdapter
  module Decoration
    class ResponseDecoratorFactory
      class << self
        def decorate(response)
          if response.key? "_source"
            {
              id: response["_id"],
            }.merge(response["_source"])
          end
        end
      end
    end
  end
end
