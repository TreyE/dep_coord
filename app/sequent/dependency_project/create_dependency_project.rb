class CreateDependencyProject < Sequent::Command
  attrs({
    name: String,
    main_branch: String
  })

  def self.create(project_name,git_uri,main_branch)
    aggregate_id = "#{git_uri}__#{project_name}"
    self.new({
      aggregate_id: aggregate_id,
      name: project_name,
      main_branch: main_branch
    })
  end
end
