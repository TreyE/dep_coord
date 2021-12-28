class DependencySourceCommandHandler < Sequent::CommandHandler
  on CreateDependencySource do |command|
    if !repository.contains_aggregate?(command.aggregate_id)
      repository.add_aggregate DependencySource.new(command)
    end
  end

  on AddDependencySourceBranch do |command|
    do_with_aggregate(command, DependencySource) do |aggregate|
      aggregate.add_branch_version(command.name, command.sha, command.version_timestamp)
    end
  end
end