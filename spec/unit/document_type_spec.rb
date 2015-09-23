require "spec_helper"

module ElasticAdapter
  describe DocumentType do
    let(:mappings) do
      {
        name: {
          type: "string",
          index_analyzer: "shingle_analyzer"
        }
      }
    end

    let(:name) { "test_index" }

    let(:subject) { DocumentType.new(name, mappings) }

    describe "#initialize" do
      it "assigns the mappings" do
        expect(subject.instance_variable_get('@mappings')).to be mappings
      end

      it "assigns the name" do
        expect(subject.instance_variable_get('@name')).to be name
      end
    end

    describe "getter" do
      describe "name" do
        it "returns the name" do
          expect(subject.name).to eq name
        end
      end

      describe "mappings" do
        it "returns the mappings" do
          expect(subject.mappings).to eq mappings
        end
      end
    end
  end
end
