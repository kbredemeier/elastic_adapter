require_relative"./shared_context.rb"

module ElasticAdapter
  describe Index do
    include_context "index context"

    describe "#suggest", :vcr do
      before :all do
        create_test_index
        doc1 = {id: 1, foo: "bar", foo_suggest: {input: "bar"}}
        doc2 = {id: 2, foo: "zoo", foo_suggest: {input: "zoo"}}
        index_documents([doc1, doc2])
      end

      after :all do
        delete_test_index
      end

      context "query 'ba'" do
        let(:query) do
          {
            foo_suggest: {
              text: "ba",
              completion: {
                field: "foo_suggest"
              }
            }
          }
        end

        let(:response) { subject.suggest(query)}

        it "returns one result" do
          expect(response.count).to eq 1
        end

        it "returns bar" do
          expect(response[:options].first).to include text: "bar"
        end

      end
    end
  end
end
