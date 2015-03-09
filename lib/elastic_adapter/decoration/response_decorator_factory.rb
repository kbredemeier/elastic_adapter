module ElasticAdapter
  module Decoration
    # This class is used inside the Response and is used to determin
    # the decorator for responses returned by elasticsearch
    #
    # @see Response#decorate
    class ResponseDecoratorFactory
      class << self
        # Takes a response and returns it with the right decorator
        # applied
        #
        # @param [Hash] response a response returned by elasticsearch
        # @return [Docorator] a decorated response
        def decorate(plain_response, *args)
          response = Response.new(plain_response)

          response = CountResponse.new(response) if args.include? :count
          response = HitDecorator.new(response) if args.include? :hit
          response = SearchResponse.new(response) if args.include? :search
          response = ValidationResponse.new(response) if args.include? :validation
          response = SuggestionResponse.new(response) if args.include? :suggestion

          response
        end

        private

        # Checks if the passed response is a response
        # from the elasticsearch suggest api
        #
        # @param [Hash] response
        # @return [Boolean]
        def suggestion?(response)
          second_key = response[response.keys[1]]
          return false unless second_key.is_a? Array
          return false if second_key.empty?
          return false unless second_key.first.is_a? Hash
          return false unless second_key.first.key? :options
          true
        end
      end
    end
  end
end
