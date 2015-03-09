require "spec_helper"

module ElasticAdapter
  module Responses
    describe ValidationResponse do
      let(:response) {{
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

      subject { ValidationResponse.new(response) }

      describe "#valid?" do
        it "returns false" do
          expect(subject.valid?).to be false
        end
      end

      describe "#explanations" do
        it "is an Array" do
          expect(subject.explanations).to be_an Array
        end

        it "includes the explanation" do
          expect(subject.explanations).to include({
            index: "twitter",
            valid: false,
            error: "some error message"
          })
        end
      end
    end
  end
end
