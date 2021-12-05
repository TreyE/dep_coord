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
      results = result.select { |r| r.is_a?(BranchDependency) }

      git_gems = results.select { |r| r.git? }
      assert_equal(7, git_gems.length)
    end
  end
end
