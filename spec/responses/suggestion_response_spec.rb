require "spec_helper"

module ElasticAdapter
  module Responses
    describe SuggestionResponse do
      let(:response){{
        shards: {
          total: 5, successful: 5, failed: 0
        },
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
      }}

      describe "suggestions" do
        subject { SuggestionResponse.new(response).suggestions }

        it "is an array" do
          expect(subject).to be_an Array
        end

        describe "first suggestion" do
          describe "#terms" do
            it "is an Array" do
              expect(subject.first.terms).to be_an Array
            end

            it "counts one" do
              expect(subject.first.terms.count).to eq 1
            end

            describe "first term" do
              describe "#text" do
                it "equals 'ba'" do
                  expect(subject.first.terms.first.text).to eq "ba"
                end

                describe "#options" do
                  it "includes the options" do
                    expect(subject.first.terms.first.options).to include({
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
