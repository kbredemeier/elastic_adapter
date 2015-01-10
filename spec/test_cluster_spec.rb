require "spec_helper"

describe "test cluster" do
  it "starts on specs with elasticsearch: true", elasticsearch: true do
    expect(Elasticsearch::Extensions::Test::Cluster.running?).to be true
  end
end
