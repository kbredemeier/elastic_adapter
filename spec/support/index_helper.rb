module IndexHelper
  WAIT_TIME = 3

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
              foo: { type: "string" },
              foo_suggest: { type: "completion" }
            }
          }
        }
      )
    }.merge(options)

    ElasticAdapter::Index.new(params)
  end

  def create_test_index(options = {})
    prefix = options.fetch(:prefix, "")
    cassette_name = prefix + vcr_cassette_name_for(self.class.metadata)

    VCR.use_cassette cassette_name do
      test_index("test_index", options).create_index.tap { sleep WAIT_TIME if ENV["RECORDING"] }
    end
  end

  def delete_test_index(options = {})
    prefix = options.fetch(:prefix, "")
    cassette_name = prefix + vcr_cassette_name_for(self.class.metadata)

    VCR.use_cassette cassette_name do
      test_index("test_index", options).delete_index # .tap { sleep 1 if ENV["RECORDING"] }
    end
  end

  def index_documents(documents, options = {})
    prefix = options.fetch(:prefix, "")
    cassette_name = prefix + vcr_cassette_name_for(self.class.metadata)

    documents = [documents] unless documents.is_a? Array

    VCR.use_cassette cassette_name do
      documents.each do |document|
        test_index("test_index", options).index(document).tap { sleep WAIT_TIME if ENV["RECORDING"] }
      end
    end
  end

  def wait(time = WAIT_TIME)
    sleep time if ENV["RECORDING"]
  end

  # Taken from https://github.com/vcr/vcr/blob/bbf43f2cd4cc18b450fb37bcb32aa9d427d4235e/lib/vcr/test_frameworks/rspec.rb
  #
  def vcr_cassette_name_for(metadata)
    description = metadata[:description]
    example_group = if metadata.key?(:example_group)
                      metadata[:example_group]
                    else
                      metadata[:parent_example_group]
                    end

    if example_group
      [vcr_cassette_name_for(example_group), description].join('/')
    else
      description
    end
  end

end
