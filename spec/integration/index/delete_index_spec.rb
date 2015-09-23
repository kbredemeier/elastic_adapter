require_relative "./shared_context.rb"

module ElasticAdapter
  describe Index do
    include_context "index context"

    describe "#delete_index", :vcr do
      context "index present" do
        let(:response) { subject.delete_index }

        before :each do |example|
          create_test_index prefix: vcr_cassette_name_for(example.metadata)
        end

        describe "repsonse" do
          include_examples "response without exception"
        end
      end

      context "index not present" do
        let(:response) { subject.delete_index }

        describe "repsonse" do
          include_examples "response with exception"
        end
      end
    end
  end
end
