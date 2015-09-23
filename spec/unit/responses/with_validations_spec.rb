require "spec_helper"

module ElasticAdapter
  describe Responses::WithValidations do
    let(:plain_response) {{
      valid: false,
      shards: {
        total: 1,
        successful: 1,
        failed: 0
      },
      explanations: [ 
        {
          index: "twitter",
          valid: false,
          error: "some error message"
        }
      ]
    }}
    subject { Response.new(plain_response).extend(Responses::WithValidations) }

    describe "#explanations" do
      it "includes the explanation" do
        expect(subject.explanations).to eq plain_response[:explanations]
      end
    end

    describe "#valid?" do
      it "returns false" do
        expect(subject.valid?).to be false
      end
    end
  end
end
