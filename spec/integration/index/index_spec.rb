require_relative "./shared_context.rb"

module ElasticAdapter
  describe Index do
    include_context "index context"

    describe "#index", :vcr do
      context "new document" do
        let(:document) { { foo: "bar" } }

        before :all do
          create_test_index
        end

        after :all do
          delete_test_index
        end

        it "indexes a document" do
          subject.index(document)
          wait(1)
          response = subject.count
          expect(response.count).to eq 1
        end
      end
    end
  end
end
