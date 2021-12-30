class DependencyGemCommandHandler < Sequent::CommandHandler
  on CreateDependencyGem do |command|
    if !repository.contains_aggregate?(command.aggregate_id)
      repository.add_aggregate DependencyGem.new(command)
    end
  end

  on ResolveDependencyGemRubyVersions do |command|
    do_with_aggregate(command, DependencyGem) do |aggregate|
      aggregate.update_ruby_versions(command.min_version, command.max_version)
    end
  end
end