class DependencyProjectCreationTest < ActiveSupport::TestCase
  test "creates a dependency project" do
    command = CreateDependencyProject.create("some_dep_project", "the_git_url", "trunk")
    Sequent.command_service.execute_commands command
  end
end
