class DependencyProjectCreated < Sequent::Event
  attrs({
    name: String,
    main_branch: String,
    remote: String
  })
end

class DependencyProjectBranchCreated < Sequent::Event
  attrs({
    name: String,
    sha: String,
    version_timestamp: DateTime
  })
end

class DependencyProjectBranchDeleted < Sequent::Event
  attrs({
    name: String
  })
end

class BranchDependencyCreated < Sequent::Event
  attrs({
    branch_name: String,
    branch_revision: String,
    branch_dependency: BranchDependency
  })
end

class BranchDependencyUpdated < Sequent::Event
  attrs({
    branch_name: String,
    branch_revision: String,
    branch_dependency: BranchDependency
  })
end

class BranchVersionCreated < Sequent::Event
  attrs({
    branch_name: String,
    branch_revision: String,
    version_timestamp: DateTime
  })
end

class BranchVersionUpdated < Sequent::Event
  attrs({
    branch_name: String,
    branch_revision: String,
    version_timestamp: DateTime
  })
end

class BranchVersionSelected < Sequent::Event
  attrs({
    branch_name: String,
    branch_revision: String
  })
end