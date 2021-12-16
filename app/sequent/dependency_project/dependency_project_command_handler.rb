class DependencyProjectCommandHandler < Sequent::CommandHandler
  on CreateDependencyProject do |command|
    if !repository.contains_aggregate?(command.aggregate_id)
      repository.add_aggregate DependencyProject.new(command)
    end
  end

  on AddBranchDependency do |command|
    do_with_aggregate(command, DependencyProject) do |aggregate|
      aggregate.add_branch_dependency(command.branch_name, command.branch_revision, command.version_timestamp, command.branch_dependency)
    end
  end
end

