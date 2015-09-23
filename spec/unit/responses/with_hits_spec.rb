require "spec_helper"

module ElasticAdapter
  describe Responses::WithHits do
    let(:plain_response) {{
      shards: {
        total: 5,
        successful: 5,
        failed: 0
      },
      hits: {
        total: 100,
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

    subject { Response.new(plain_response).extend(Responses::WithHits) }

    describe "#hits" do
      it "includes the hit in a flattened format" do
        doc = {
          index: "twitter",
          type: "tweet",
          id: "1",
          source: {
            user: "kimchy",
            postDate: "2009-11-15T14:12:12",
            message: "trying out Elasticsearch"
          }
        }

        expect(subject.hits).to include doc
      end

      describe "#count" do
        it "returns the count" do
          expect(subject.hits.count).to be plain_response[:hits][:total]
        end
      end
    end
  end
end
