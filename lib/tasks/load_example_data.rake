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
  dep_command = ResolveDependencyGemRubyVersions.new({
    aggregate_id: "rails__3.2.22.5",
    min_version: "000001.000008.000007",
    max_version: "000002.000001.999999"
  })
  Sequent.command_service.execute_commands dep_command
=end
end
