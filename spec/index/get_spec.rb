require_relative "./shared_context.rb"

module ElasticAdapter
  describe Index do
    include_context "index context"

    describe "#get", :vcr do
      context "document exists" do
        let(:document) { {id: "1", foo: "bar"} }
        before :all do
          create_test_index
          index_documents(foo: "bar", id: 1)
        end

        after :all do
          delete_test_index
        end

        let(:response) { subject.get(1) }

        describe "response" do
          it "contains the document" do
            expect(response).to eq document
          end
        end
      end
    end
  end
end