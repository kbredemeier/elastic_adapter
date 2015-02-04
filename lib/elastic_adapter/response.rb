require "delegate"
module ElasticAdapter
  # Serves to wrap the responses from elasticsearch
  class Response < ::SimpleDelegator
    # Checks if the operation was successfull
    #
    # @response [Boolean]
    def success?
      !failure?
    end

    # Checks if the operation failed
    #
    # @return [Boolean]
    def failure?
      @failure = has_key?(:exception)
    end
  end
end
