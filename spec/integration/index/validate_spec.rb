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

        describe "valid?" do
          it "is false" do
            expect(response.valid?).to be false
          end
        end
      end

      context "valid query" do
        let(:query) {{ query: { match_all: {} } }}
        let(:response) { subject.validate(query) }

        it "is true" do
          expect(response.valid?).to eq true
        end
      end
    end
  end
end
