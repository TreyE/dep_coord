class GitBranchDependency < Sequent::ValueObject
  attrs({
    revision: String,
    branch: String,
    remote: String,
    version_constraint: String
  })
end
