require "spec_helper"

module ElasticAdapter
  module Responses
    describe CountResponse do
      let(:response) {{
        count: 1,
        shards: {
            total: 5,
            successful: 5,
            failed: 0
        }
      }}

      subject { CountResponse.new(response) }

      describe "#count" do
        it "equals 1" do
          expect(subject.count).to eq 1
        end
      end
    end
  end
end
