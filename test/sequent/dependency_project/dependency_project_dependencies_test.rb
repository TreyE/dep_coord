class DependencyProjectDependenciesTest < ActiveSupport::TestCase
  test "creates a dependency project and children from a gemfile" do
    command = CreateDependencyProject.create("some_dep_project", "the_git_url", "trunk")
    Sequent.command_service.execute_commands command

    file_content = File.read(
      File.expand_path(
        File.join(
          File.dirname(__FILE__),
          "..",
          "..",
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
        "some_dep_project",
        "the_git_url",
        "trunk",
        "asdkjlkennfskd",
        res
      )
    end
    Sequent.command_service.execute_commands *commands  
  end
end