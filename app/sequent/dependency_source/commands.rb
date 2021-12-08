class CreateDependencySource < Sequent::Command
  attrs({
    name: String,
    remote: String,
    main_branch: String
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

class AddDependencySourceBranch < Sequent::Command
  attrs({
    name: String,
    sha: String
  })

  def self.create(project_name,git_uri, branch_name, sha)
    aggregate_id = "#{git_uri}__#{project_name}"
    self.new({
      aggregate_id: aggregate_id,
      name: branch_name,
      sha: sha
    })
  end
end