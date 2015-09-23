require "spec_helper"

module ElasticAdapter
  describe Response do
    let(:object) {{
      "foo" => { "bim" => "bam" },
      "bar" => [
        { "biz" => "buz" }
      ],
      "boo" => "bam"
    }}

    subject { Response.new(object) }

    describe "symbolize keys" do
      it "symbolizes all keys" do
        expected = {
          foo: { bim: "bam" },
          bar: [
            { biz: "buz" }
          ],
          boo: "bam"
        }
        expect(subject.object).to eq expected
      end
    end
  end
end
