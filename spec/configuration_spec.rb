require "spec_helper"

module ElasticAdapter
  describe Configuration do
    describe "#to_hash" do
      let(:options) do
        {
          url: "url",
          log: "log",
          document_type: "document_type",
          index_name: "index_name",
          wrapper: "wrapper",
          settings: "settings",
          mappings: "mappings"
        }
      end

      let(:subject) { Configuration.new(options) }

      it "returns the options as a hash" do
        expect(subject.to_hash).to eq options
      end
    end

    describe "#initialize" do
      let(:options) do
        {
          url: "url",
          log: "log",
          document_type: "document_type",
          index_name: "index_name",
          wrapper: "wrapper",
          settings: "settings",
          mappings: "mappings"
        }
      end

      let(:subject) { Configuration.new(options) }

      it "assigns the url" do
        expect(subject.url).to eq "url"
      end

      it "assigns log" do
        expect(subject.log).to eq "log"
      end

      it "assigns index_name" do
        expect(subject.index_name).to eq "index_name"
      end

      it "assigns wrapper" do
        expect(subject.wrapper).to eq "wrapper"
      end

      it "assigns settings" do
        expect(subject.settings).to eq "settings"
      end

      it "assigns mappings" do
        expect(subject.mappings).to eq "mappings"
      end

      it "assigns document_type" do
        expect(subject.document_type).to eq "document_type"
      end
    end
  end
end
