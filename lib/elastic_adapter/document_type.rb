# rubocop:disable Metrics/LineLength
module ElasticAdapter
  # This class is intended to hold information about
  # a document in an elasticsearch index
  #
  # @see http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/mapping.html Elasticsearch Mappings
  #
  # @attr_reader [String] name the name of the document
  # @attr_reader [Hash] mappings the mappings for the document
  class DocumentType
    attr_reader :name, :mappings

    # @param [String] name
    # @param [Hash] mappings
    def initialize(name, mappings)
      @name = name
      @mappings = mappings
    end
  end
end
