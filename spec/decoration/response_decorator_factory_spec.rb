require "spec_helper"

module ElasticAdapter
  module Decoration
    describe ResponseDecoratorFactory do
      describe "class methods" do
        describe "#decorate" do
          context "response with exception" do
            let(:response) {{ exception: ArgumentError.new }}
            let(:subject) { ResponseDecoratorFactory.decorate(response)}

            it "returns the unmodified response" do
              expect(subject).to be response
            end
          end

          context "response with acknowledged" do
            let(:response) {{ acknowledged: true }}
            let(:subject) { ResponseDecoratorFactory.decorate(response)}

            it "returns the unmodified response" do
              expect(subject).to be response
            end
          end

          context "response with source" do
            let(:response) {{ source: {} }}
            let(:subject) { ResponseDecoratorFactory.decorate(response)}

            it "returns a HitDecorator" do
              expect(subject).to be_a HitDecorator
            end
          end

          context "response with hits" do
            let(:response) {{ hits: {hits: []} }}
            let(:subject) { ResponseDecoratorFactory.decorate(response)}

            it "returns a SearchResponse" do
              expect(subject).to be_a SearchResponse
            end
          end

          context "response with count" do
            let(:response) {{ count: {count: 1} }}
            let(:subject) { ResponseDecoratorFactory.decorate(response)}

            it "returns a CountResponse" do
              expect(subject).to be_a CountResponse
            end
          end

          context "response with everything_else" do
            let(:response) {{ everything_else: {} }}
            let(:subject) { ResponseDecoratorFactory.decorate(response)}

            it "returns a SuggestionResponse" do
              expect(subject).to be_a SuggestionResponse
            end
          end

        end
      end
    end
  end
end
