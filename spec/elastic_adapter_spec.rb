require "spec_helper"

describe ElasticAdapter do
  describe "#configure" do
    before do
      ElasticAdapter.configure do |config|
        config.elasticsearch_url = "http://test:9999"
      end
    end

    it "returns the configured url" do
      repo = ProductRepository.new
      expect(repo.url).to eq "http://test:9999"
    end
  end
end
