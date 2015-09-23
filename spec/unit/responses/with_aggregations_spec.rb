require "spec_helper"

module ElasticAdapter
  describe Responses::WithAggregations do
    let(:plain_response) {{
      aggregations: {
        products: {
          doc_count_error_upper_bound: 46,
          buckets: [
            {
              key: "Product A",
              doc_count: 100
            },
            {
              key: "Product Z",
              doc_count: 52
            }
          ]
        }
      }
    }}
    subject { Response.new(plain_response).extend(Responses::WithAggregations) }

    describe "#aggregations" do
      it "includes the products aggregation" do
        expect(subject.aggregations).to eq plain_response[:aggregations]
      end
    end
  end
end
