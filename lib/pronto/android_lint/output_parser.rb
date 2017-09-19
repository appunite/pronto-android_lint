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
        lint_result.xpath("//issue").map do |issue|
          {
            path: parse_path(issue.xpath(".//location").attribute("file").value),
            line: issue.xpath(".//location").attribute("line").value.to_i,
            level: TYPE_WARNINGS[issue.attribute("severity").value],
            message: create_message(issue)
          }
        end
      rescue => e
        raise "Error while parsing file: #{@path}\n#{e.message}"
      end

      private
      # removed `/builds/group/project/` from path
      # to match pronto patch path
      def parse_path(path)
        path.split("/")
          .reject(&:empty?)
          .drop(ENV["PRONTO_ANDROID_LINT_PATH_SHIFT"].to_i)
          .join("/")
      end

      def create_message(issue)
        "#{issue.attribute("summary").value}\n\n#{issue.attribute("message").value}

        #{issue.attribute("explanation").value}"
      end
    end
  end
end
