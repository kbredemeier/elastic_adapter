require "spec_helper"

module ElasticAdapter
  module Responses
    describe BaseResponse do
      let(:object) { Class.new }

      subject { BaseResponse.new(object) }

      describe "delegation" do
        describe "#object" do
          it "returns the object" do
            expect(subject.object).to be object
          end
        end
      end
    end
  end
end
