require "spec_helper"

module ElasticAdapter
  describe Responses::WithException do
    let(:plain_response) {{
      exception: ArgumentError.new()
    }}

    subject { Response.new(plain_response).extend(Responses::WithException) }

    describe "#exception" do
      it "returns the exception" do
        expect(subject.exception).to be plain_response[:exception]
      end
    end
  end
end
