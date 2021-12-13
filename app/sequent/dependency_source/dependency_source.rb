class DependencySource < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply DependencySourceCreated, command.attributes
  end

  def add_branch_version(name, sha)
    existing_branch = @branches.detect { |br| br.name == name }
    if existing_branch
      apply DependencySourceBranchUpdated, {name: name, head: sha}
    else
      apply DependencySourceBranchCreated, {name: name, head: sha}
    end
  end

  on DependencySourceCreated do |event|
    @name = event.name
    @remote = event.remote
    @main_branch = event.main_branch
    @branches = []
  end

  on DependencySourceBranchCreated do |event|
    @branches << DependencySourceBranch.new({
      name: event.name,
      head: event.head
    })
  end
  
  on DependencySourceBranchUpdated do |event|
    branch = @branches.detect { |br| br.name == event.name }
    branch.head = event.head
  end
end
