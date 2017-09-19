require "spec_helper"
require "pronto/android_lint/output_parser"
require "pathname"

RSpec.describe Pronto::AndroidLint::OutputParser do
  let(:parser) { described_class.new(path) }
  let(:path) { "#{Pathname.pwd}/spec/fixtures/lint-results.xml" }

  describe "#parse" do
    subject { parser.parse }
    before { ENV["PRONTO_ANDROID_LINT_PATH_SHIFT"]="3" }

    it "parses output" do
      expect(subject.first[:path]).to eq("app/src/main/res/values/strings.xml")
      expect(subject.first[:line]).to eq(4)
      expect(subject.first[:level]).to eq(:warning)
    end
  end
end
