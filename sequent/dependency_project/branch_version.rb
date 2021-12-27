class BranchVersion < Sequent::ValueObject
  attrs({
    sha: String,
    version_timestamp: DateTime,
    dependencies: array(BranchDependency)
  })
end
