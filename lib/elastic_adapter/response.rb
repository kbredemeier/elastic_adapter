module ElasticAdapter
  # Serves to wrap the responses from elasticsearch
  class Response < ::ElasticAdapter::Decoration::Decorator
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

    # Decorates the response with the right decorator
    #
    # @return [Decorator] returns the decorated response
    def decorate
      Decoration::ResponseDecoratorFactory.decorate(self)
    end

    private

    # Sanitizes a nested hash. It removes leading underscores
    # from keys and turns them into symbols. This methods gets
    # overridden by other response decorators.
    #
    # @param [Hash] hash
    # @return [Hash]
    def alter_object(object)
      object.inject({}) do |result, (key, value)|
        new_value = nil

        case value
        when Hash
          new_value = alter_object(value)
        when Array
          new_value = value.map { |i| alter_object(i) }
        else
          new_value = value
        end

        result[remove_leading_underscore(key).to_sym] = new_value

        result
      end
    end

    def remove_leading_underscore(string)
      /^_?(.*)$/.match(string)[1]
    end
  end
end
