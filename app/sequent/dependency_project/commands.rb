class CreateDependencyProject < Sequent::Command
  attrs({
    name: String,
    main_branch: String,
    remote: String
  })

  def self.create(project_name,git_uri,main_branch)
    aggregate_id = "#{git_uri}__#{project_name}"
    self.new({
      aggregate_id: aggregate_id,
      name: project_name,
      remote: git_uri,
      main_branch: main_branch
    })
  end
end

class AddBranchDependency < Sequent::Command
  attrs({
    branch_name: String,
    branch_revision: String,
    branch_dependency: BranchDependency,
    version_timestamp: DateTime
  })

  def self.create(project_name,git_uri,branch_name,branch_revision,version_timestamp,branch_dependency)
    aggregate_id = "#{git_uri}__#{project_name}"
    self.new({
      aggregate_id: aggregate_id,
      branch_name: branch_name,
      branch_revision: branch_revision,
      branch_dependency: branch_dependency,
      version_timestamp: version_timestamp
    })
  end
end
