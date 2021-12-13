class DependencySourceBranchVersion < Sequent::ValueObject
  attrs({
    sha: String,
    version_timestamp: DateTime
  })
end