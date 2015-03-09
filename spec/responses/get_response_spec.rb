require "spec_helper"

module ElasticAdapter
  module Responses
    describe GetResponse do
      let(:response) {{
        index: "twitter",
        type: "tweet",
        id: "1",
        version: 1,
        found: true,
        source: {
            user: "kimchy",
            postDate: "2009-11-15T14:12:12",
            message: "trying out Elasticsearch"
        }
      }}

      subject { GetResponse.new(response) }

      describe "#document" do
        it "returns the source" do
          expect(subject.document).to eq response[:source].merge(id: response[:id])
        end
      end

    end
  end
end
