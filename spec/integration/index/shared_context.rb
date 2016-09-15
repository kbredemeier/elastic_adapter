require "spec_helper"

RSpec.shared_context "index context" do
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

  let(:bar_doc) { { id: 1, foo: "bar", foo_suggest: {input: "bar"} } }
  let(:zoo_doc) { { id: 2, foo: "zoo", foo_suggest: {input: "zoo"} } }

  subject do
    ElasticAdapter::Index.new(
      name: name,
      settings: settings,
      document_type: document_type,
      url: url,
      log: log
    )
  end
end
