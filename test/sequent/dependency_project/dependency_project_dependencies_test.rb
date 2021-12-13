require "test_helper"

class DependencyProjectDependenciesTest < ActiveSupport::TestCase
  test "creates a dependency project and children from a gemfile" do
    command = CreateDependencyProject.create("enroll", "git@github.com:ideacrew/enroll.git", "trunk")
    Sequent.command_service.execute_commands command

    file_content = File.read(
      File.expand_path(
        File.join(
          Rails.root,
          "test",
          "models",
          "parsers",
          "Gemfile.lock"
        )
      )
    )
    parser = Parsers::GemLockfileParser.new
    result = parser.parse file_content
    results = result.select { |r| r.is_a?(BranchDependency) }

    commands = results.map do |res|
      AddBranchDependency.create(
        "enroll",
        "git@github.com:ideacrew/enroll.git",
        "trunk",
        "f3308d0aada7d61cc93ec281aacb3b8432008aaf",
        DateTime.new(2021,10,31,15,11,41),
        res
      )
    end
    Sequent.command_service.execute_commands *commands  
  end
end
