class DependencyGemProjector < Sequent::Projector
  manages_tables DependencyGemRecord, BranchVersionRubyVersionRecord

  on DependencyGemCreated do |event|
    create_record(
      DependencyGemRecord,
      {
        aggregate_id: event.aggregate_id,
        name: event.name,
        version: event.version
      }
    )
  end

  on DependencyGemRubyVersionsResolved do |event|
    update_all_records(
      DependencyGemRecord,
      {aggregate_id: event.aggregate_id},
      {ruby_min_version: event.min_version, ruby_max_version: event.max_version}
    )
  end
end