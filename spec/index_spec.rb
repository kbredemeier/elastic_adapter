require "spec_helper"

RSpec.shared_examples "response without exception" do
  it "is a Response" do
    expect(response).to be_a ElasticAdapter::Response
  end

  it "has no exception" do
    expect(response).not_to have_key :exception
  end
end

RSpec.shared_examples "response with exception" do
  it "is a Response" do
    expect(response).to be_a ElasticAdapter::Response
  end

  it "has an exception" do
    expect(response).to have_key :exception
  end
end

module ElasticAdapter
  describe Index, :vcr do
    def test_index(name = "test_index", options = {})
      params = {
        name: name,
        url: "http://localhost:9200",
        log: true,
        settings: {},
        document_type: OpenStruct.new(
          name: "test_doc",
          mappings: {
            test_doc: {
              properties: {
                foo: { type: "string" }
              }
            }
          }
        )
      }.merge(options)

      Index.new(params)
    end

    def create_test_index(name = "test_index", options = {})
      test_index(name, options).create_index
    end

    def delete_test_index(name = "test_index", options = {})
      test_index(name, options).delete_index
    end

    def index_document(document, name = "test_index", options = {})
      test_index(name, options).index(document)
    end

    def wait_for_elasticsearch
      if ENV["RECORDING"]
        sleep 1
      end
    end

    let(:name) { "test_index" }
    let(:mappings) do
      {
        test_index: {
          properties: {
            foo: {
              type: "string"
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

    let(:subject) do
      Index.new(
        name: name,
        settings: settings,
        document_type: document_type,
        url: url,
        log: log
      )
    end

    describe "#initialize" do
      it "assigns the name" do
        expect(subject.instance_variable_get('@name')).to be name
      end

      it "assigns the settings" do
        expect(subject.instance_variable_get('@settings')).to be settings
      end

      it "assigns the document_type" do
        expect(subject.instance_variable_get('@document_type')).to be document_type
      end

      it "assigns the url" do
        expect(subject.instance_variable_get('@url')).to be url
      end

      it "assigns the log" do
        expect(subject.instance_variable_get('@log')).to be log
      end
    end

    describe "getter" do
      describe "name" do
        it "returns the name" do
          expect(subject.name).to eq name
        end
      end

      describe "settings" do
        it "returns the settings" do
          expect(subject.settings).to eq settings
        end
      end

      describe "document_type" do
        it "returns the document_type" do
          expect(subject.document_type).to eq document_type
        end
      end

      describe "url" do
        it "returns the url" do
          expect(subject.url).to eq url
        end
      end

      describe "log" do
        it "returns the log" do
          expect(subject.log).to eq log
        end
      end

      describe "client" do
        it "returns the client" do
          expect(subject.client).to be_a ::Elasticsearch::Transport::Client
        end
      end
    end

    describe "#search" do
      before :all do
        create_test_index
        index_document(foo: "bar", id: 1)
        index_document(foo: "zoo", id: 2)
        sleep 1
      end

      after :all do
        delete_test_index
      end

      context "match_all" do
        it "returns all documents" do
          expect(subject.search({query: {match_all: {}}}).count).to eq 2
        end
      end

      context "zoo" do
        let(:response) { subject.search(query: {match: {foo: "zoo"}})}
        it "returns one document" do
          expect(response.count).to eq 1
        end

        it "returns the wanted document" do
          expect(response[:hits].first[:id]).to eq "2"
          expect(response[:hits].first[:foo]).to eq "zoo"
        end
      end
    end

    describe "#get" do
      context "document exists" do
        let(:document) { {id: "1", foo: "bar"} }
        before :all do
          create_test_index
          index_document(foo: "bar", id: 1)
        end

        after :all do
          delete_test_index
        end

        let(:response) { subject.get(1) }

        describe "response" do
          it "contains the document" do
            expect(response).to eq document
          end
        end
      end
    end

    describe "#index" do
      context "new document" do
        let(:document) { { foo: "bar" } }

        before :all do
          create_test_index
        end

        after :all do
          delete_test_index
        end

        it "indexes a document" do
          subject.index(document)
          # wait_for_elasticsearch
          sleep 1
          expect(subject.count).to eq 1
        end

        it "invokes to_hash on the document" do
          expect(document).to receive(:to_hash).and_return(document.to_hash)
          subject.index(document)
        end
      end

      context "existing document" do
        let(:document) { {foo: "baz", id: 1} }

        before :all do
          create_test_index
          # wait_for_elasticsearch
          sleep 1
          index_document foo: "bar", id: 1
          # wait_for_elasticsearch
          sleep 1
        end

        after :all do
          delete_test_index
        end

        it "doesn't change the document count" do
          expect(subject.count).to eq 1
          subject.index(document)
          sleep 1
          # wait_for_elasticsearch
          expect(subject.count).to eq 1
        end

        it "invokes to_hash on the document" do
          expect(document).to receive(:to_hash).and_return(document.to_hash)
          subject.index(document)
        end

        it "updates the document" do
          expect(subject.get(1)[:foo]).to eq "baz"
        end
      end
    end

    describe "#count" do
      context "empty index" do
        before :all do
          create_test_index
          wait_for_elasticsearch
        end

        after :all do
          delete_test_index
        end

        it "returs the amount of all documents" do
          expect(subject.count).to eq 0
        end
      end

      context "not empty index" do
        before :all do
          create_test_index
          index_document foo: "bar"
          sleep 1
          # wait_for_elasticsearch
        end

        after :all do
          delete_test_index
        end

        it "returns 1" do
          expect(subject.count).to eq 1
        end
      end
    end

    describe "#delete_index" do
      context "index present" do
        before :each do
          create_test_index
        end

        let(:response) { subject.delete_index }

        describe "repsonse" do
          include_examples "response without exception"
        end
      end

      context "index not present" do
        let(:response) { subject.delete_index }

        describe "repsonse" do
          include_examples "response with exception"
        end
      end
    end

    describe "#create_index" do
      context "index is present" do
        before :all do
          create_test_index
        end

        after :all do
          delete_test_index
        end

        let(:response) { subject.create_index }

        describe "response" do
          # TODO fix this
          # Somehow VCR doesn't record the requests for the current context
          include_examples "response with exception"
        end
      end

      context "index not present" do
        after :each do
          delete_test_index
        end

        let(:response) { subject.create_index }

        describe "response" do
          include_examples "response without exception"
        end
      end
    end
  end
end
