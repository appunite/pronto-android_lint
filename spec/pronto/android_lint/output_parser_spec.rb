require "spec_helper"
require "pronto/android_lint/output_parser"
require "pathname"

RSpec.describe Pronto::AndroidLint::OutputParser do
  let(:parser) { described_class.new(path) }

  describe "#parse" do
    subject { parser.parse }
    before { ENV["PRONTO_ANDROID_LINT_PATH_SHIFT"]="3" }

    context "when xml is valid" do
      let(:path) { "#{Pathname.pwd}/spec/fixtures/lint-results.xml" }

      it "parses output" do
        expect(subject.first[:path]).to eq("/builds/user/project/app/src/main/res/values/strings.xml")
        expect(subject.first[:line]).to eq(4)
        expect(subject.first[:level]).to eq(:warning)
      end
    end

    context "when issue contains multiple locations" do
      let(:path) { "#{Pathname.pwd}/spec/fixtures/multiple_locations.xml" }

      it "parses output" do
        expect(subject.count).to eq(2)
        expect(subject.first[:path]).to eq("/builds/user/project/app/src/main/res/values/strings.xml")
        expect(subject.first[:line]).to eq(4)
        expect(subject.last[:path]).to eq("/builds/user/project/app/src/main/res/values/other.xml")
        expect(subject.last[:line]).to eq(18)
      end
    end

    context "when xml is invalid" do
      let(:path) { "#{Pathname.pwd}/spec/fixtures/invalid_format.xml" }

      it "raises" do
        expect{ subject }.to raise_error(RuntimeError, /Error while parsing file: #{path}\n/)
      end
    end
  end
end
