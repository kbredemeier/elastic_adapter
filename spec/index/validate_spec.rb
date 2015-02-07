require_relative "./shared_context.rb"

module ElasticAdapter
  describe Index do
    include_context "index context"

    describe "#validate", :vcr do
      before :all do
        create_test_index
      end

      after :all do
        delete_test_index
      end

      context "invalid query" do
        let(:query) do
          {
            asd: "[[[ BOOM! ]]]"
          }
        end

        let(:response) { subject.validate(query) }

        it "is false" do
          expect(response).to eq false
        end

        it "is a response" do
          expect(response).to be_a Decoration::ValidationResponse
        end
      end

      context "valid query" do
        let(:query) do
          {
            query: {
              match_all: {}
            }
          }
        end

        let(:response) { subject.validate(query) }

        it "is true" do
          expect(response).to eq true
        end

        it "is a response" do
          expect(response).to be_a Decoration::ValidationResponse
        end
      end
    end
  end
end
