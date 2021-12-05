class BranchVersion < Sequent::ValueObject
  attrs({
    sha: String,
    dependencies: array(BranchDependency)
  })
end
