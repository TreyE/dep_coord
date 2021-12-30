class DependencyProjectWorkflow < Sequent::Workflow
  on BranchDependencyCreated do |event|
    if event.branch_dependency.gem?
      command = CreateDependencyGem.create(
        event.branch_dependency.name,
        event.branch_dependency.gem.version_constraint
      )
      Sequent.command_service.execute_commands command
    end
  end

  on BranchDependencyUpdated do |event|
    if event.branch_dependency.gem?
      command = CreateDependencyGem.create(
        event.branch_dependency.name,
        event.branch_dependency.gem.version_constraint
      )
      Sequent.command_service.execute_commands command
    end
  end
end