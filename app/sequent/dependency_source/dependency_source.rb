class DependencySource < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply DependencySourceCreated, command.attributes
  end

  def add_branch_version(name, sha, version_timestamp)
    existing_branch = @branches.detect { |br| br.name == name }
    if existing_branch
      latest_version = existing_branch.versions.max_by(&:version_timestamp)
      existing_version = existing_branch.versions.detect { |v| v.sha == sha }
      if existing_version
        apply DependencySourceBranchVersionUpdated, {name: name, head: sha, version_timestamp: version_timestamp}
      else
        apply DependencySourceBranchVersionCreated, {name: name, head: sha, version_timestamp: version_timestamp}
      end
      if latest_version.blank? || (latest_version && (latest_version.version_timestamp < version_timestamp))
        apply DependencySourceBranchUpdated, {name: name, head: sha, version_timestamp: version_timestamp}
      end
    else
      apply DependencySourceBranchCreated, {name: name, head: sha, version_timestamp: version_timestamp}
    end
  end

  on DependencySourceCreated do |event|
    @name = event.name
    @remote = event.remote
    @main_branch = event.main_branch
    @branches = []
  end

  on DependencySourceBranchCreated do |event|
    version = DependencySourceBranchVersion.new({
      sha: event.head,
      version_timestamp: event.version_timestamp
    })
    @branches << DependencySourceBranch.new({
      name: event.name,
      head: event.head,
      versions: [version]
    })
  end

  on DependencySourceBranchUpdated do |event|
    branch = @branches.detect { |br| br.name == event.name }
    branch.head = event.head
  end

  on DependencySourceBranchVersionCreated do |event|
    branch = @branches.detect { |br| br.name == event.name }
    new_version = DependencySourceBranchVersion.new({
      sha: event.head,
      version_timestamp: event.version_timestamp
    })
    branch.versions << new_version
  end

  on DependencySourceBranchVersionUpdated do |event|
    branch = @branches.detect { |br| br.name == event.name }
    version = branch.versions.detect { |v| v.sha == event.head }
    version.version_timestamp = event.version_timestamp
  end
end
