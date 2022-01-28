class DependencyProjectBranchLifeCycleTest < ActiveSupport::TestCase
  test "creates and destroys a branch" do
    command = CreateDependencyProject.create("some_dep_project_with_a_branch", "the_git_url", "trunk")
    Sequent.command_service.execute_commands command

    res = BranchDependency.new({
      name: "agem",
      gem: GemBranchDependency.new({
        version_constraint: "1.0.1"
      })
    })

    dep_command = AddBranchDependency.create(
      "some_dep_project_with_a_branch",
      "the_git_url",
      "some_branch",
      "f3308d0aada7d61cc93ec281aacb3b8432008aaf",
      DateTime.new(2021,10,31,15,11,41),
      res
    )

    Sequent.command_service.execute_commands dep_command

    delete_command = DeleteProjectBranch.create(
      "some_dep_project_with_a_branch",
      "the_git_url",
      "some_branch"
    )    
    Sequent.command_service.execute_commands delete_command
  end
end
