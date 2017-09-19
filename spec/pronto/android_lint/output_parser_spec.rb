require "spec_helper"
require "pronto/android_lint/output_parser"
require "pathname"

RSpec.describe Pronto::AndroidLint::OutputParser do
  let(:parser) { described_class.new(path) }

  describe "#parse" do
    subject { parser.parse }
    before { ENV["PRONTO_ANDROID_LINT_PATH_SHIFT"]="3" }

    context "valid xml" do
      let(:path) { "#{Pathname.pwd}/spec/fixtures/lint-results.xml" }

      it "parses output" do
        expect(subject.first[:path]).to eq("app/src/main/res/values/strings.xml")
        expect(subject.first[:line]).to eq(4)
        expect(subject.first[:level]).to eq(:warning)
      end
    end

    context "invalid xml" do
      let(:path) { "#{Pathname.pwd}/spec/fixtures/invalid_format.xml" }

      it "raises" do
        expect{ subject }.to raise_error(RuntimeError, /Error while parsing file: #{path}\n/)
      end
    end
  end
end
