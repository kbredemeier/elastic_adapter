require "spec_helper"

module ElasticAdapter
  describe Configuration do
    describe "attributes" do
      before :each do
        @config = Configuration.new
      end

      describe "url" do
        it "default value is http://localhost:9200" do
          expect(@config.url).to eq "http://localhost:9200"
        end

        it "can set the value" do
          @config.url= "test"
          expect(@config.url).to eq "test"
        end
      end

      describe "log" do
        it "default value is true" do
          expect(@config.log).to be true
        end

        it "can set the value" do
          @config.log = false
          expect(@config.log).to be false
        end
      end
    end

    describe "#initialize" do
      it "accepts a hash" do
        expect{ Configuration.new({}) }.not_to raise_error
      end

      it "assigns the url" do
        expect(Configuration.new({url: "test"}).url).to eq "test"
      end

      it "assigns log" do
        expect(Configuration.new({log: false}).log).to be false
      end
    end
  end
end
