class DependencySourceCommandHandler < Sequent::CommandHandler
  on CreateDependencySource do |command|
    repository.add_aggregate DependencySource.new(command)
  end

  on AddDependencySourceBranch do |command|
    do_with_aggregate(command, DependencySource) do |aggregate|
      aggregate.add_branch_version(command.name, command.sha)
    end
  end
end