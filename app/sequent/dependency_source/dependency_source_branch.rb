class DependencySourceBranch < Sequent::ValueObject
  attrs({
    name: String,
    head: String
  })
end