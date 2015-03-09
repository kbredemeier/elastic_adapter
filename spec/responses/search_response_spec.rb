require "spec_helper"

module ElasticAdapter
  module Responses
    describe SearchResponse do
      let(:response) {{
        shards: {
          total: 5,
          successful: 5,
          failed: 0
        },
        hits: {
          total: 1,
          hits: [
            {
              index: "twitter",
              type: "tweet",
              id: "1",
              source: {
                user: "kimchy",
                postDate: "2009-11-15T14:12:12",
                message: "trying out Elasticsearch"
              }
            }
          ]
        }
      }}

      subject { SearchResponse.new(response) }

      describe "hits" do
        it "returns the hits" do
          expect(subject.hits).to include({
            id: "1",
            user: "kimchy",
            postDate: "2009-11-15T14:12:12",
            message: "trying out Elasticsearch"
          })
        end
      end
    end
  end
end
