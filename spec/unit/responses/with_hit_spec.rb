require "spec_helper"

module ElasticAdapter
  describe Responses::WithHits do
    let(:plain_response) {{
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
    subject { Response.new(plain_response).extend(Responses::WithHit) }

    describe "#hit" do
      it "is the hit" do
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

        expect(subject.hit).to eq doc

      end

      describe "#found?" do
        it "returns true" do
          expect(subject.hit.found?).to be true
        end
      end

      describe "#found" do
        it "returns the version" do
          expect(subject.hit.version).to eq 1
        end
      end
    end
  end
end
