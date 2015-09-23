require "delegate"

module ElasticAdapter
  class Response < SimpleDelegator
    def initialize(object)
      __setobj__(symbolize_keys(object))
    end

    def object
      __getobj__
    end

    private

    def symbolize_keys(obj)
      if obj.is_a? Hash
        Hash[obj.map { |k, v| [k.to_sym, symbolize_keys(v)] }]
      elsif obj.is_a? Array
        obj.map { |e| symbolize_keys(e) }
      else
        obj
      end
    end
  end
end
