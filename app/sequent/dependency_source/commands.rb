class CreateDependencySource < Sequent::Command
  attrs({
    name: String,
    remote: String,
    main_branch: String
  })

  def self.create(project_name,git_uri,main_branch)
    normalized_uri = ProjectUriNormalizer.normalize(git_uri)
    aggregate_id = "#{normalized_uri}__#{project_name}"
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
    sha: String,
    version_timestamp: DateTime
  })

  def self.create(project_name,git_uri, branch_name, sha, version_timestamp)
    normalized_uri = ProjectUriNormalizer.normalize(git_uri)
    aggregate_id = "#{normalized_uri}__#{project_name}"
    self.new({
      aggregate_id: aggregate_id,
      name: branch_name,
      sha: sha,
      version_timestamp: version_timestamp
    })
  end
end