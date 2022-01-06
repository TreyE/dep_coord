desc "Load the example data"
task :load_example_data => :environment do
  dependencies = [
    ["ideacrew/event_source", "trunk"],
    ["ideacrew/resource_registry", "trunk"],
    ["ideacrew/acapi", "trunk"],
    ["ideacrew/aca_entities", "trunk"]
  ]

  dependencies.each do |dep|
    dsb = DependencySourceBaseliner.new(*dep)
    dsb.baseline!
  end

  projects = [
    ["ideacrew/enroll", "trunk"],
    ["ideacrew/gluedb", "trunk"],
    ["ideacrew/gluedb", "me_carrier_boarding"]
  ]

  projects.each do |proj|
    pbb = ProjectBranchBaseliner.new(*proj)
    pbb.baseline!
  end

=begin
  command = CreateDependencyProject.create("enroll", "git@github.com:ideacrew/enroll.git", "trunk")
  Sequent.command_service.execute_commands command

  file_content = File.read(
    File.expand_path(
      File.join(
        Rails.root,
        "test",
        "models",
        "parsers",
        "Gemfile.lock"
      )
    )
  )
  parser = Parsers::GemLockfileParser.new
  result = parser.parse file_content
  results = result.select { |r| r.is_a?(BranchDependency) }

  commands = results.map do |res|
    AddBranchDependency.create(
      "enroll",
      "git@github.com:ideacrew/enroll.git",
      "trunk",
      "f3308d0aada7d61cc93ec281aacb3b8432008aaf",
      DateTime.new(2021,10,31,15,11,41),
      res
    )
  end
  Sequent.command_service.execute_commands *commands
  
  create_source_command = CreateDependencySource.create(
    "event_source",
    "https://github.com/ideacrew/event_source.git",
    "trunk"
  )

  add_branch_command = AddDependencySourceBranch.create(
    "event_source",
    "https://github.com/ideacrew/event_source.git",
    "trunk",
    "dc587952d215241de333d17998882176aed3c948",
    DateTime.new(2021,10,31,13,11,41)
  )

  create_rr_source_command = CreateDependencySource.create(
    "resource_registry",
    "https://github.com/ideacrew/resource_registry.git",
    "trunk"
  )

  add_rr_branch_command = AddDependencySourceBranch.create(
    "resource_registry",
    "https://github.com/ideacrew/resource_registry.git",
    "trunk",
    "7b8f396afde849e584d0a749ade9ee88f1717e26",
    DateTime.new(2021,10,1,12,11,41)
  )

  create_ae_source_command = CreateDependencySource.create(
    "aca_entities",
    "https://github.com/ideacrew/aca_entities.git",
    "trunk"
  )

  add_ae_branch_command = AddDependencySourceBranch.create(
    "aca_entities",
    "https://github.com/ideacrew/aca_entities.git",
    "trunk",
    "a3f2fbeaf278996b20139ba2b4528420b3f74afd",
    DateTime.new(2021,12,27,15,46,32)
  )

  Sequent.command_service.execute_commands add_ae_branch_command

  Sequent.command_service.execute_commands(
    create_source_command,
    add_branch_command,
    create_rr_source_command,
    add_rr_branch_command,
    create_ae_source_command,
    add_ae_branch_command
  )
=end
end
