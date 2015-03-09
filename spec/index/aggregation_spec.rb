require_relative "./shared_context.rb"

module ElasticAdapter
  describe Index do
    include_context "index context"

    describe "#aggregate", :vcr do
      before :all do
        create_test_index
        index_documents foo: "bar", group: "A"
        index_documents foo: "baz", group: "A"
        index_documents foo: "boo", group: "B"
      end

      after :all do
        delete_test_index
      end

      describe "response" do
        let(:query) {{
          aggs: {
            group: {
              terms: { field: "group" }
            }
          }
        }}

        it "is a AggregationResponse" do
          expect(subject.aggregate(query)).to be_a Decoration::AggregationResponse
        end
      end
    end
  end
end
