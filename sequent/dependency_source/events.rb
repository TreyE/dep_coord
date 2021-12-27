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
    head: String,
    version_timestamp: DateTime
  })
end

class DependencySourceBranchUpdated < Sequent::Event
  attrs({
    name: String,
    head: String,
    version_timestamp: DateTime
  })
end

class DependencySourceBranchVersionCreated < Sequent::Event
  attrs({
    name: String,
    head: String,
    version_timestamp: DateTime
  })
end

class DependencySourceBranchVersionUpdated < Sequent::Event
  attrs({
    name: String,
    head: String,
    version_timestamp: DateTime
  })
end