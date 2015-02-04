require "spec_helper"

module ElasticAdapter
  describe Response do
    describe "delegation" do
      let(:hash) { { foo: "bar" } }
      let(:response) { Response.new(hash) }

      it "delegates to the hash" do
        expect(hash).to receive(:key?).with(:foo)
        response.key? :foo
      end

      it "returns the underlaying hash" do
        expect(hash).to eq response
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
