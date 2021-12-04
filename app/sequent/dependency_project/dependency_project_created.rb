class DependencyProjectCreated < Sequent::Event
  attrs({
    name: String,
    main_branch: String
  })
end
