class DependencyProject < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply DependencyProjectCreated, command.attributes
  end

  on DependencyProjectCreated do |event|
    @name = event.name
    @main_branch = event.main_branch
    @branches = []
  end
end
