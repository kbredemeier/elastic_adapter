require_relative "./shared_context.rb"

module ElasticAdapter
  describe Index do
    include_context "index context"

    describe "#count", :vcr do
      context "empty index" do
        before :all do
          create_test_index
        end

        after :all do
          delete_test_index
        end

        before { @result = subject.count }

        it "returns the amount of all documents" do
          expect(@result['count']).to eq 0
        end
      end

      context "not empty index" do
        before :all do
          create_test_index
          index_documents foo: "bar"
        end

        after :all do
          delete_test_index
        end

        before { @result = subject.count }

        it "returns 1" do
          expect(@result['count']).to eq 1
        end
      end
    end
  end
end
