module ElasticAdapter
  class Configuration
    include ElasticAdapter::AttributeAccessor

    attribute_reader :log, :url, :index_name, :wrapper, :settings, :mappings, :document_type

    def initialize(options = {})
      @log = options.fetch :log do
        ENV['ELASTIC_ADAPTER_LOG'] || true
      end

      @url = options.fetch :url do
        ENV['ELASTIC_ADAPTER_URL'] || "http://localhost:9200"
      end

      @document_type = options.fetch(:document_type)
      @index_name = options.fetch(:index_name)
      @wrapper = options.fetch(:wrapper, OpenStruct)
      @settings = options.fetch(:settings)
      @mappings = options.fetch(:mappings)
    end

    def to_hash
      @options_hash ||= options_hash
    end

    private

    def options_hash
      hash = {}

      attributes.each do |attr|
        hash[attr] = self.send(attr)
      end

      hash
    end
  end
end
