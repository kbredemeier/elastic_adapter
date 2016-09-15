require "spec_helper"

module ElasticAdapter
  describe Index do
    let(:name) { "test_index" }
    let(:mappings) do
      {
        test_index: {
          properties: {
            foo: {
              type: "string",
              foo_suggest: { type: "completion" }
            }
          }
        }
      }
    end
    let(:document_type) do
      OpenStruct.new(name: "test_doc", mappings: mappings)
    end
    let(:settings) { { number_of_shards: 1 } }
    let(:log) { true }
    let(:url) { "http://localhost:9200"}
    let(:indices) { double("indices") }
    let(:client) { double("client") }

    subject do
      ElasticAdapter::Index.new(
        name: name,
        settings: settings,
        document_type: document_type,
        url: url,
        log: log,
        client: client
      )
    end

    before do
      allow(client).to receive(:indices).and_return(indices)
    end

    let(:query) {{ query: { match_all: {} } }}

    describe "#initialize" do
      it "takes a hash as arguments" do
        expect { subject }.not_to raise_error
      end
    end

    describe "#name" do
      it "returns the name" do
        expect(subject.name).to be name
      end
    end

    describe "#settings" do
      it "returns the settings" do
        expect(subject.settings).to be settings
      end
    end

    describe "#document_type" do
      it "returns the document type" do
        expect(subject.document_type).to be document_type
      end
    end

    describe "#url" do
      it "returns the url" do
        expect(subject.url).to be url
      end
    end

    describe "#log" do
      it "returns log" do
        expect(subject.log).to be log
      end
    end

    describe "client" do
      it "returns a client" do
        expect(subject.client).to be client
      end
    end

    describe "#create_index" do
      it "creates the index" do
        expect(indices).to receive(:create)
          .with(
            index: name,
            body: { 
              mappings: document_type.mappings,
              settings: settings
            }
          )
        subject.create_index
      end
    end

    describe "#delete_index" do
      it "deletes the index" do
        expect(indices).to receive(:delete).with(index: name)
        subject.delete_index
      end
    end

    describe "#count" do
      it "does a count request" do
        expect(client).to receive(:count).with(index: name, body: query)
        subject.count(query)
      end

      it "returns the response" do
        expect(client).to receive(:count).and_return({})
        result = subject.count(query)
        expect(result).to eq({})
      end
    end

    describe "#index" do
      let(:doc) {{ id: 1, foo: "bar" }}

      it "indexes the document" do
        expect(client).to receive(:index)
          .with(
            index: name,
            id: 1,
            type: document_type.name,
            body: { foo: "bar" }
          )
        subject.index(doc)
      end

      it "returns the response" do
        expect(client).to receive(:index).and_return({})
        result = subject.index(doc)
        expect(result).to eq({})
      end
    end

    describe "#get" do
      it "does a get request" do
        expect(client).to receive(:get).with(index: name, type: document_type.name, id: 1)
        subject.get(1)
      end

      it "returns the response" do
        expect(client).to receive(:get).and_return({})
        result = subject.get(1)
        expect(result).to eq({})
      end
    end

    describe "#search" do
      it "does a search request" do
        expect(client).to receive(:search).with(index: name, body: query)
        subject.search(query)
      end

      it "returns the response" do
        expect(client).to receive(:search).and_return({})
        result = subject.search(query)
        expect(result).to eq({})
      end
    end

    describe "#suggest" do
      it "does a suggest request" do
        expect(client).to receive(:suggest).with(index: name, body: query)
        subject.suggest(query)
      end

      it "returns the response" do
        expect(client).to receive(:suggest).and_return({})
        result = subject.suggest(query)
        expect(result).to eq({})
      end
    end

    describe "#aggregate" do
      it "does a aggregate request" do
        expect(client).to receive(:search).with(index: name, body: query)
        subject.aggregate(query)
      end

      it "returns the response" do
        expect(client).to receive(:search).and_return({})
        result = subject.aggregate(query)
        expect(result).to eq({})
      end
    end

    describe "#validate" do
      it "does a validate request" do
        expect(indices).to receive(:validate_query).with(index: name, body: query, explain: true)
        subject.validate(query)
      end

      it "returns the response" do
        expect(indices).to receive(:validate_query).and_return({})
        result = subject.validate(query)
        expect(result).to eq({})
      end
    end
  end
end
