require "test_helper"

module Parsers
  class GemLockfileParserTest < ActiveSupport::TestCase
    test "can parse a simple lock file" do
      file_content = File.read(
        File.expand_path(
          File.join(
            File.dirname(__FILE__),
            "Gemfile.lock"
          )
        )
      )
      parser = Parsers::GemLockfileParser.new
      result = parser.parse file_content
      raise result.inspect
    end
  end
end
