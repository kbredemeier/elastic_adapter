require "spec_helper"

module ElasticAdapter
  describe "#configure" do
    before :each do
      ElasticAdapter.configure do |config|
        config.url = "http://test:9999"
      end
    end

    after :each do
      ElasticAdapter.reset
    end

    it "returns the configured url" do
      repo = Repository.new
      expect(repo.url).to eq "http://test:9999"
    end
  end

  describe "reset" do
    before do
      ElasticAdapter.configure do |config|
        config.url = "http://test:9999"
      end
    end

    it "resets the configuration" do
      ElasticAdapter.reset
      config = ElasticAdapter.configuration
      expect(config.url).to eq "http://localhost:9200"
    end
  end
end
