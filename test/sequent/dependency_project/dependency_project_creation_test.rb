class DependencyProjectCreationTest < ActiveSupport::TestCase
  test "creates a dependency project" do
    command = CreateDependencyProject.create("some_dep_project", "the_git_url", "trunk")
    Sequent.command_service.execute_commands command
  end

  test "creates a dependency idempotently" do
    command1 = CreateDependencyProject.create("some_dep_project", "the_git_url", "trunk")
    command2 = CreateDependencyProject.create("some_dep_project", "the_git_url", "trunk")
    Sequent.command_service.execute_commands command1, command2
  end
end
