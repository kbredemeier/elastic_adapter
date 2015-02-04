require "spec_helper"

RSpec.shared_examples "response without exception" do
  it "is a Response" do
    expect(response).to be_a ElasticAdapter::Response
  end

  it "has no exception" do
    # expect(response).not_to have_key :exception
    expect(response.key? :exception).to be false
  end
end

RSpec.shared_examples "response with exception" do
  it "is a Response" do
    expect(response).to be_a ElasticAdapter::Response
  end

  it "has an exception" do
    # expect(response).to have_key :exception
    expect(response.key? :exception).to be true
  end
end

module ElasticAdapter
  describe Index do
    def create_test_index(name = "test_index")
      Index.new(
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
      ).create_index
    end

    def delete_test_index(name = "test_index")
      Index.new(
        name: name,
        url: "http://localhost:9200",
        log: true,
        settings: {},
        document_type: OpenStruct.new(
          name: "test_doc",
          mappings: {}
        )
      ).delete_index
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
      context "index not present" do
        after :each do
          delete_test_index
        end

        let(:response) { subject.create_index }

        describe "response" do
          include_examples "response without exception"
        end
      end

      context "index present" do
        before :all do
          create_test_index
        end

        after :all do
          delete_test_index
        end

        let(:response) { subject.create_index }

        describe "response" do
          include_examples "response with exception"
        end
      end
    end
  end
end
