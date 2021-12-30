class DependencyGem < Sequent::AggregateRoot
  def initialize(command)
    super(command.aggregate_id)
    apply DependencyGemCreated, command.attributes
  end

  def update_ruby_versions(min_version, max_version)
    apply(
      DependencyGemRubyVersionsResolved, 
      {
        min_version: min_version,
        max_version: max_version
      }
    )
  end

  on DependencyGemCreated do |event|
    @name = event.name
    @version = event.version
  end

  on DependencyGemRubyVersionsResolved do |event|
    @min = event.min_version
    @max = event.max_version
  end
end