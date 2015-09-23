require "spec_helper"

module ElasticAdapter
  describe Responses::WithSuggestions do
    let(:plain_response) {{
      shards: {
          total: 5, successful: 5, failed: 0
      },
      suggest: {
        foo_suggest: [
          {
            text: "ba",
            offset: 0,
            length: 2,
            options: [
              {
                text: "bar",
                score: 1.0
              }
            ]
          }
        ]
      }
    }}
    subject { Response.new(plain_response).extend(Responses::WithSuggestions) }

    describe "#suggestions" do
      it "includes the suggestion" do
        expect(subject.suggestions).to eq plain_response[:suggest]
      end
    end
  end
end
