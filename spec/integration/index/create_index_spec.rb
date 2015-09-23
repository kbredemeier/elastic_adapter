require_relative "./shared_context.rb"

module ElasticAdapter
  describe Index do
    include_context "index context"

    describe "#create_index", :vcr do
      context "index is present" do
        before :all do
          create_test_index
        end

        after :all do
          delete_test_index
        end

        let(:response) { subject.create_index }

        describe "response" do
          # TODO fix this
          # Somehow VCR doesn't record the requests for the current context
          include_examples "response with exception"
        end
      end

      context "index not present" do
        after :each do
          delete_test_index
        end

        let(:response) { subject.create_index }

        describe "response" do
          include_examples "response without exception"
        end
      end
    end
  end
end
