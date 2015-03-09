require "spec_helper"

module ElasticAdapter
  module Responses
    describe SanitizedResponse do
      describe "symbolize keys" do
        it "turns all strings in Hash keys to symbols" do
          hash = {"foo" => "bar"}
          response = SanitizedResponse.new(hash)
          expect(response.keys.first).to be_a Symbol
        end

        it "removes all leading underscores from keys" do
          hash = {"_foo" => {"_bar" => "baz" }}
          expected = {foo: {bar: "baz" }}
          response = SanitizedResponse.new(hash)
          expect(response.object).to eq expected
        end

        it "works with arrays" do
          hash = { "foo" => ["bar", "buz"] }
          expected = { foo: ["bar", "buz"] }
          response = SanitizedResponse.new(hash)
          expect(response.object).to eq expected
        end

        it "works with hashes in arrays" do
          hash = { boo: [ {"foo" => ["bar", "buz"] } ] }
          expected = { boo: [ {foo: ["bar", "buz"] } ] }
          response = SanitizedResponse.new(hash)
          expect(response.object).to eq expected
        end
      end
    end
  end
end
