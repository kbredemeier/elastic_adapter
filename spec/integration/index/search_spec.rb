require_relative "./shared_context.rb"

module ElasticAdapter
  describe Index do
    include_context "index context"

    describe "#search", :vcr do
      before :all do
        create_test_index
        index_documents(id: 1, foo: "bar", foo_suggest: {input: "bar"})
        index_documents(id: 2, foo: "zoo", foo_suggest: {input: "zoo"})
      end

      after :all do
        delete_test_index
      end

      context "match_all" do
        it "returns all documents" do
          expect(subject.search({query: {match_all: {}}}).hits.count).to eq 2
        end
      end

      context "zoo" do
        let(:response) { subject.search(query: {match: {foo: "zoo"}})}
        it "returns one document" do
          expect(response.hits.count).to eq 1
        end

        it "returns the wanted document" do
          expect(response.hits.first[:_id]).to eq "2"
          expect(response.hits.first[:_source][:foo]).to eq "zoo"
        end
      end
    end
  end
end
