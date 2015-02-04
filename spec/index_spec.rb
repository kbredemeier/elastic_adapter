require "spec_helper"

module ElasticAdapter
  describe Index do
    let(:config) do
      ElasticAdapter::Configuration.new(
        index_name: "test_index",
        document_type: "test_type",
        wrapper: OpenStruct,
        settings: { number_of_shards: 1 },
        mappings: {}
      )
    end

    describe "#initialize" do
      it "accepts a Configuration as param" do
        expect{
          Index.new(config)
        }.not_to raise_error
      end
    end

    describe "#config" do
      it "returns the configuration" do
        expect(Index.new(config).config).to be config
      end
    end
  end
end
