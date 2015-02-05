module ElasticAdapter
  # Serves to wrap the responses from elasticsearch
  class Response < ::SimpleDelegator

    # Returns the underlaying object
    #
    # @return [Object] the decorated object
    def object
      __getobj__
    end

    # Checks if the operation was successfull
    #
    # @return [Boolean]
    def success?
      !failure?
    end

    # Checks if the operation failed
    #
    # @return [Boolean]
    def failure?
      key?(:exception)
    end

    # Decorates the Response with the right decorator
    #
    # @return [Decorator] returns the decorated response
    def decorate
      Decorators::ResponseDecoratorFactory.decorate(self)
    end
  end
end
