require 'active_support/core_ext/object/try'
require 'nokogiri'

module Pronto
  module AndroidLint
    class OutputParser
      attr_reader :path

      TYPE_WARNINGS = {
        "Warning" => :warning,
        "Info"  => :info
      }

      def initialize(path)
        @path = path
      end

      def parse
        lint_result = File.open(@path) { |f| Nokogiri::XML(f) }
        lint_result.xpath("//issue").flat_map do |issue|
          issue.xpath(".//location").map do |location|
            {
              path: location.attribute("file").try(:value),
              line: location.attribute("line").try(:value).to_i,
              level: TYPE_WARNINGS[issue.attribute("severity").value],
              message: create_message(issue)
            }
          end
        end
      rescue => e
        raise "Error while parsing file: #{@path}\n#{e.message}"
      end

      private
      def create_message(issue)
        "#{issue.attribute("summary").try(:value)}\n\n#{issue.attribute("message").try(:value)}

        #{issue.attribute("explanation").try(:value)}"
      end
    end
  end
end
