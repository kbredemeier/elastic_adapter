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

        it "returns the amount of all documents" do
          expect(subject.count).to eq 0
        end

        it "is a fixnum" do
          expect(subject.count).to be_a Fixnum
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

        it "returns 1" do
          expect(subject.count).to eq 1
        end

        it "is a fixnum" do
          expect(subject.count).to be_a Fixnum
        end
      end
    end
  end
end
