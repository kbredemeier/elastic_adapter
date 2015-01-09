require "spec_helper"

describe ElasticAdapter do
  describe Repository do
    describe "initialize" do
      it "accepts an hash and assigns it to @configuration" do
        config = {foo: "bar"}
        repo = Repository.new({}.merge(config))
        expect(repo.configuration).to eq config
      end
    end

  end
end
