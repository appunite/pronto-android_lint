require "spec_helper"
require "pronto/android_lint/output_parser"
require "pathname"

RSpec.describe Pronto::AndroidLint::OutputParser do
  let(:parser) { described_class.new(path) }

  describe "#parse" do
    subject { parser.parse }
    let(:path) { "#{Pathname.pwd}/spec/fixtures/lint-results.xml" }

    it "parses every location" do
      expect(subject.count).to eq(3)
    end

    it "parses path and line" do
      expect(subject[0][:path]).to eq("/builds/user/project/app/src/main/res/values/first.xml")
      expect(subject[0][:line]).to eq(4)
    end

    it "sets 0 as line when value is missing" do
      expect(subject[2][:path]).to eq("/builds/user/project/app/src/main/res/values/third.xml")
      expect(subject[2][:line]).to eq(0)
    end
  end
end
