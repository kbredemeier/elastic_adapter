require "spec_helper"

module ElasticAdapter
  module Responses
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

          context "get" do
            let(:response) {{ source: {} }}
            subject { ResponseDecoratorFactory.decorate(response, :get) }

            it "returns a GetResponse" do
              expect(subject).to be_a GetResponse
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
            let(:response) {{
              my_suggest_1: [
                {
                  text: "amsterdma",
                  offset: 4,
                  length: 9,
                  options: [
                    {
                      text: "amsterdam",
                      freq: 77,
                      score: 0.8888889
                    }
                  ]
                }
              ]
            }}
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

          context "mixed aggregation and search" do
            let(:response){{
              hits: { hits: [] },
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

            subject { ResponseDecoratorFactory.decorate(response, :aggregation, :search) }

            it "doent raise an exception" do
              expect{
                subject
              }.not_to raise_error
            end

            it "behaves like a AggregationResponse" do
              expect(subject).to respond_to :aggregations
            end

            it "behaves like a SearchResponse" do
              expect(subject).to respond_to :count
            end
          end
        end
      end
    end
  end
end
