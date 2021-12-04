class DependencyProjectCommandHandler < Sequent::CommandHandler
  on CreateDependencyProject do |command|
    repository.add_aggregate DependencyProject.new(command)
  end
end

