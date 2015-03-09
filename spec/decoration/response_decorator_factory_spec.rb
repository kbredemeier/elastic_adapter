require "spec_helper"

module ElasticAdapter
  module Decoration
    describe ResponseDecoratorFactory do
      describe "class methods" do
        describe "#decorate" do
          context "count" do
            let(:response) {{ acknowledged: true }}
            subject { ResponseDecoratorFactory.decorate(response, :count) }

            it "returns a CountResponse" do
              expect(subject).to be_a CountResponse
            end
          end

          context "hit" do
            let(:response) {{ source: {} }}
            subject { ResponseDecoratorFactory.decorate(response, :hit) }

            it "returns a HitDecorator" do
              expect(subject).to be_a HitDecorator
            end
          end

          context "search" do
            let(:response) {{ hits: {hits: []} }}
            subject { ResponseDecoratorFactory.decorate(response, :search) }

            it "returns a SearchResponse" do
              expect(subject).to be_a SearchResponse
            end
          end

          context "validation" do
            let(:response) {{ valid: true }}
            subject { ResponseDecoratorFactory.decorate(response, :validation) }

            it "returns a ValidationResponse" do
              expect(subject).to be_a ValidationResponse
            end
          end

          context "suggestion" do
            let(:response) {{ foo: "bar", foo_suggestion: [{options: []}] }}
            subject { ResponseDecoratorFactory.decorate(response, :suggestion) }

            it "returns a SuggestionResponse" do
              expect(subject).to be_a SuggestionResponse
            end
          end

          context "aggregation" do
            let(:response){{
              aggregations: {
                products: {
                  doc_count_error_upper_bound: 46,
                  buckets: [
                    {
                      key: "Product A",
                      doc_count: 100
                    }
                  ]
                }
              }
            }}

            subject { ResponseDecoratorFactory.decorate(response, :aggregation) }

            it "returns a AggregationResponse" do
              expect(subject).to be_a AggregationResponse
            end
          end
        end
      end
    end
  end
end
