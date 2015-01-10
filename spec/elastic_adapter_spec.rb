require "spec_helper"

module ElasticAdapter
  describe "#configure" do
    before do
      ElasticAdapter.configure do |config|
        config.url = "http://test:9999"
      end
    end

    after do
      # Configure back to default.
      # Otherwise some specs might fail.
      ElasticAdapter.configure do |config|
        config.url = "http://localhost:9200"
      end
    end

    it "returns the configured url" do
      repo = Repository.new
      expect(repo.url).to eq "http://test:9999"
    end
  end
end
