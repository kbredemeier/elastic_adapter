require "spec_helper"

module ElasticAdapter
  describe Response do
    describe "delegation" do
      let(:hash) { { foo: "bar" } }
      let(:response) { Response.new(hash) }

      describe "#original_object" do
        it "returns the original hash" do
          expect(response.original_object).to be hash
        end
      end

      describe "object" do
        it "returns the sanitized hash" do
          expect(response.object).to eq({ foo: "bar" })
        end
      end
    end

    describe "sanitization" do
      it "turns all strings in Hash keys to symbols" do
        hash = {"foo" => "bar"}
        response = Response.new(hash)
        expect(response.keys.first).to be_a Symbol
      end

      it "removes all leading underscores from keys" do
        hash = {"_foo" => {"_bar" => "baz" }}
        expected = {foo: {bar: "baz" }}
        response = Response.new(hash)
        expect(response.object).to eq expected
      end

      it "works with arrays" do
        hash = { "foo" => ["bar", "buz"] }
        expected = { foo: ["bar", "buz"] }
        response = Response.new(hash)
        expect(response.object).to eq expected
      end
    end

    describe "#failure?" do
      context "no exception" do
        let(:hash) { { foo: "bar" } }
        let(:response) { Response.new(hash) }

        it "returns false" do
          expect(response.failure?).to be false
        end
      end

      context "with exception" do
        let(:hash) { { foo: "bar", exception: ArgumentError.new("foo") } }
        let(:response) { Response.new(hash) }

        it "returns true" do
          expect(response.failure?).to be true
        end
      end
    end
  end
end
