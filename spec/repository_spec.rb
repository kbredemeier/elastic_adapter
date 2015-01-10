require "spec_helper"

module ElasticAdapter
  describe Repository do
    describe "initialize" do
      it "accepts an hash and assigns it to @configuration" do
        config = {foo: "bar"}
        repo = Repository.new({}.merge(config))
        expect(repo.config).to eq config
      end

      context "defaults" do
        let(:subject) { Repository.new }

        it "assigns url" do
          expect(subject.url).to eq "http://localhost:9200"
        end

        it "enables logging" do
          expect(subject.log).to be true
        end
      end
    end

  end
end
