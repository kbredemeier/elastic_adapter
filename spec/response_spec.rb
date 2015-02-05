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

      describe "object" do
        it "returns the underlaying object" do
          expect(response.object).to be hash
        end
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

    describe "#decorate" do
      context "find request" do
        let(:document) { {foo: "bar", id: 1} }
        let(:response_hash) do
          {
            "found" => true,
            "_id" => 1,
            "_source" => {
              "foo" => "bar"
            }
          }
        end

        let(:response) do 
          response = Response.new(response_hash)
        end

        it "is the document" do
          expect(response.decorate.to_hash).to eq document
        end
      end
    end
  end
end
