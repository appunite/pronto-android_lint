require "pronto"
require "pronto/android_lint/output_parser"

module Pronto
  class AndroidLintRunner < Runner
    def run
      paths = ENV["PRONTO_ANDROID_LINT_RESULT_PATHS"]
      return [] unless @patches && paths

      offences = paths.split(",")
        .map{ |path| AndroidLint::OutputParser.new(path).parse }
        .flatten
        .compact

      @patches.select { |p| p.additions > 0 }
        .map { |p| inspect(p, offences) }
        .flatten
        .compact
    end

    private

    def inspect(patch, offences)
      patch_path = patch.delta.new_file[:path]

      messages = []

      offences.select { |offence| offence[:path].end_with?(patch_path) }
        .each do |offence|
          messages += patch.added_lines
            .select { |line| line.new_lineno == offence[:line] }
            .map{ |line| new_message(offence, line) }
      end

      messages.compact
    end

    def new_message(offence, line)
      path = line.patch.delta.new_file[:path]

      Message.new(path, line, offence[:level], offence[:message])
    end
  end
end
