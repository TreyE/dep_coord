class DependencyProject < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply DependencyProjectCreated, command.attributes
  end

  def add_branch_dependency(branch_name, branch_revision, version_timestamp, branch_dependency)
    existing_branch = @branches.detect { |b| b.name == branch_name }
    if !existing_branch
      apply DependencyProjectBranchCreated, {name: branch_name, sha: branch_revision, version_timestamp: version_timestamp}
      apply BranchDependencyCreated, {branch_name: branch_name, branch_revision: branch_revision, branch_dependency: branch_dependency}
    else
      existing_branch_version = existing_branch.versions.detect { |v| v.sha == branch_revision }
      most_recent_branch_version = existing_branch.versions.max_by(&:version_timestamp)
      if existing_branch_version
        apply BranchVersionUpdated, {branch_name: branch_name, branch_revision: branch_revision, version_timestamp: version_timestamp}
        if most_recent_branch_version.blank? || (most_recent_branch_version && (most_recent_branch_version.version_timestamp < version_timestamp))
          apply BranchVersionSelected, {branch_name: branch_name, branch_revision: branch_revision}
        end
        existing_dependency = existing_branch_version.dependencies.detect { |d| d.name == branch_dependency.name }
        if existing_dependency
          apply BranchDependencyUpdated, {branch_name: branch_name, branch_revision: branch_revision, branch_dependency: branch_dependency}
        else
          apply BranchDependencyCreated, {branch_name: branch_name, branch_revision: branch_revision, branch_dependency: branch_dependency}
        end
      else
        apply BranchVersionCreated, {branch_name: branch_name, branch_revision: branch_revision, version_timestamp: version_timestamp}
        if most_recent_branch_version.blank? || (most_recent_branch_version.version_timestamp < version_timestamp)
          apply BranchVersionSelected, {branch_name: branch_name, branch_revision: branch_revision}
        end
        apply BranchDependencyCreated, {branch_name: branch_name, branch_revision: branch_revision, branch_dependency: branch_dependency}
      end
    end
  end

  def delete_branch(branch_name)
    apply DependencyProjectBranchDeleted, {name: branch_name}
  end

  on DependencyProjectCreated do |event|
    @name = event.name
    @main_branch = event.main_branch
    @remote = event.remote
    @branches = []
  end

  on DependencyProjectBranchCreated do |event|
    new_version = BranchVersion.new({
      sha: event.sha,
      version_timestamp: event.version_timestamp,
      dependencies: []
    })
    new_branch = DependencyProjectBranch.new({
      name: event.name,
      head: event.sha,
      versions: [new_version]
    })
    @branches << new_branch
  end
  
  on DependencyProjectBranchDeleted do |event|
    _discarded, kept = @branches.partition do |branch|
      branch.name == event.name
    end
    @branches = kept
  end

  on BranchDependencyCreated do |event|
    branch = @branches.detect { |b| b.name == event.branch_name }
    branch_version = branch.versions.detect { |b| b.sha == event.branch_revision }
    branch_version.dependencies << event.branch_dependency
  end

  on BranchDependencyUpdated do |event|
    branch = @branches.detect { |b| b.name == event.branch_name }
    branch_version = branch.versions.detect { |b| b.sha == event.branch_revision }
    branch_version.dependencies = branch_version.dependencies.map do |d|
      if d.name == event.branch_dependency.name
        event.branch_dependency
      else
        d
      end
    end
  end

  on BranchVersionCreated do |event|
    branch = @branches.detect { |b| b.name == event.branch_name }
    new_version = BranchVersion.new({
      sha: event.branch_revision,
      version_timestamp: event.version_timestamp,
      dependencies: []
    })
    branch.versions << new_version
  end

  on BranchVersionSelected do |event|
    branch = @branches.detect { |b| b.name == event.branch_name }
    branch.head = event.branch_revision
  end
end
