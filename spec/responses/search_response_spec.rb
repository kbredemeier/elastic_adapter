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
        },
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
        },
        suggest: {
          foo_suggest: [
            {
              text: "ba",
              offset: 0,
              length: 2,
              options: [
                {
                  text: "bar",
                  score: 1.0
                }
              ]
            }
          ]
        }
      }}

      subject { SearchResponse.new(response) }

      context "empty response" do
        let(:response) {{}}

        it "should not fail" do
          expect { subject }.not_to raise_error
        end
      end

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

      describe "#aggregations" do
        it "returns the aggregations" do
          expect(subject.aggregations).to eq response[:aggregations]
        end
      end

      describe "suggestions" do
        it "is an array" do
          expect(subject.suggestions).to be_an Array
        end

        describe "first suggestion" do
          describe "#terms" do
            it "is an Array" do
              expect(subject.suggestions.first.terms).to be_an Array
            end

            it "counts one" do
              expect(subject.suggestions.first.terms.count).to eq 1
            end

            describe "first term" do
              describe "#text" do
                it "equals 'ba'" do
                  expect(subject.suggestions.first.terms.first.text).to eq "ba"
                end

                describe "#options" do
                  it "includes the options" do
                    expect(subject.suggestions.first.terms.first.options).to include({
                      text: "bar",
                      score: 1.0
                    })
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
