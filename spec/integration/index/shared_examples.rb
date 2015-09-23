RSpec.shared_examples "response without exception" do
  it "is a Response" do
    expect(response).to be_a ElasticAdapter::Response
  end

  it "has no exception" do
    expect(response).not_to have_key :exception
  end
end

RSpec.shared_examples "response with exception" do
  it "is a Response" do
    expect(response).to be_a ElasticAdapter::Response
  end

  it "has an exception" do
    expect(response).to have_key :exception
  end
end
