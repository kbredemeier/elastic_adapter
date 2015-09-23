require "spec_helper"

module ElasticAdapter
  describe Responses::WithCount do
    let(:plain_response) {{
      count: 1,
      shards: {
        total: 5,
        successful: 5,
        failed: 0
      }
    }}

    subject { Response.new(plain_response).extend(Responses::WithCount) }

    describe "#count" do
      it "returns the count" do
        expect(subject.count).to eq 1
      end
    end
  end
end
