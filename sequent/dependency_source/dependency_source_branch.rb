class DependencySourceBranch < Sequent::ValueObject
  attrs({
    name: String,
    head: String,
    versions: array(DependencySourceBranchVersion)
  })
end