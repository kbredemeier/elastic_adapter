require "spec_helper"

module ElasticAdapter
  module Decoration
    describe Decorator do
      describe "delegation" do
        let(:hash) { { foo: "bar" } }
        let(:subject) { Decorator.new(hash) }

        it "delegates to the hash" do
          expect(hash).to receive(:key?).with(:foo)
          subject.key? :foo
        end

        it "returns the underlaying object" do
          expect(hash).to eq subject
        end
      end

      describe "instance methods" do
        let(:object) { { foo: "bar" } }
        let(:subject) { Decorator.new(object) }

        describe "object" do
          it "returns the underlaying object" do
            expect(subject.object).to eq object
          end
        end
      end

      describe "class methods" do
        let(:subject) { Decorator }

        describe "#decorate" do
          let(:object) { OpenStruct.new(foo: "bar") }

          it "decorates a single object" do
            expect(Decorator.decorate(object).first).to be_a Decorator
          end

          it "decorates each object in a collection" do
            decorated_collection = Decorator.decorate([object])
            decorated_collection.each do |item|
              expect(item).to be_a Decorator
            end
          end
        end
      end
    end
  end
end
