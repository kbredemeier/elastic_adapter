module ElasticAdapter
  module Responses
    # This class is used to decorate responses
    #
    class ResponseDecoratorFactory
      class << self
        # Takes a response and multiple symbols and decorates the response.
        #
        # @param [Hash] response a response returned by elasticsearch
        # @param [Array<Symbol>] args the decorators the response should be decorated with.
        #   Currently valid args are :count, :hit, :search, :validation, :suggestion
        # @return [Docorator] a decorated response
        def decorate(plain_response, *args)
          response = SanitizedResponse.new(plain_response)

          response = CountResponse.new(response) if args.include? :count
          response = GetResponse.new(response) if args.include? :get
          response = SearchResponse.new(response) if args.include? :search
          response = ValidationResponse.new(response) if args.include? :validation
          response = SuggestionResponse.new(response) if args.include? :suggestion
          response = AggregationResponse.new(response) if args.include? :aggregation

          response
        end
      end
    end
  end
end
