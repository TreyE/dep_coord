class DependencyProjectCreated < Sequent::Event
  attrs({
    name: String,
    main_branch: String
  })
end

class DependencyProjectBranchCreated < Sequent::Event
  attrs({
    name: String,
    sha: String
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
    branch_revision: String
  })
end