class DependencyProjectBranch < Sequent::ValueObject
  attrs({
    name: String,
    head: String,
    versions: array(BranchVersion)
  })
end
