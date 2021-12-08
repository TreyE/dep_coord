class DependencySourceProjector < Sequent::Projector
  manages_tables DependencySourceRecord, DependencySourceBranchRecord

  on DependencySourceCreated do |event|
    create_record(
      DependencySourceRecord,
      {
        aggregate_id: event.aggregate_id,
        name: event.name,
        main_branch: event.main_branch,
        remote: event.remote
      }
    )
  end

  on DependencySourceBranchCreated do |event|
    create_record(
      DependencySourceBranchRecord,
      {
        dependency_source_record_aggregate_id: event.aggregate_id,
        name: event.name,
        head: event.head
      }
    )
  end

  on DependencySourceBranchUpdated do |event|
    update_all_records(
      DependencySourceBranchRecord,
      {
        dependency_source_record_aggregate_id: event.aggregate_id
      },
      {
        name: event.name,
        head: event.head
      }
    )
  end
end