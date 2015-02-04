module ElasticAdapter
  class DocumentType
    attr_reader :name, :mappings
    def initialize(name, mappings)
      @name = name
      @mappings = mappings
    end
  end
end
