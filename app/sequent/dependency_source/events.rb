class DependencySourceCreated < Sequent::Event
  attrs({
    name: String,
    remote: String,
    main_branch: String
  })
end

class DependencySourceBranchCreated < Sequent::Event
  attrs({
    name: String,
    head: String
  })
end

class DependencySourceBranchUpdated < Sequent::Event
  attrs({
    name: String,
    head: String
  })
end