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
          expect(subject.count).to eq 1
        end

        it "invokes to_hash on the document" do
          expect(document).to receive(:to_hash).and_return(document.to_hash)
          subject.index(document)
        end
      end

      context "existing document" do
        let(:document) { {foo: "baz", id: 1} }

        before :all do
          create_test_index
          index_documents foo: "bar", id: 1
        end

        after :all do
          delete_test_index
        end

        it "doesn't change the document count" do
          expect(subject.count).to eq 1
          subject.index(document)
          expect(subject.count).to eq 1
        end

        it "invokes to_hash on the document" do
          expect(document).to receive(:to_hash).and_return(document.to_hash)
          subject.index(document)
        end

        it "updates the document" do
          expect(subject.get(1)[:foo]).to eq "baz"
        end
      end
    end
  end
end
