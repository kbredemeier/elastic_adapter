require "spec_helper"

module ElasticAdapter
  module Responses
    describe AggregationResponse do
      let(:response){{
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

      subject { AggregationResponse.new(response) }

      describe "#aggregations" do
        it "counts one" do
          expect(subject.aggregations.count).to eq 1
        end

        it "contains products" do
          expect(subject.aggregations).to have_key :products
        end

        describe "products" do
          it "counts two" do
            expect(subject.aggregations[:products].count).to eq 2
          end

          it "contains Product A with it's count" do
            expect(subject.aggregations[:products]).to include({
              term: "Product A",
              count: 100
            })
          end

          it "contains Product Z with it's count" do
            expect(subject.aggregations[:products]).to include({
              term: "Product Z",
              count: 52
            })
          end
        end
      end
    end
  end
end
