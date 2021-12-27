class DependencySourceProjector < Sequent::Projector
  manages_tables DependencySourceRecord, DependencySourceBranchRecord, DependencySourceBranchVersionRecord

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
    dsbr = create_record(
      DependencySourceBranchRecord,
      {
        dependency_source_record_aggregate_id: event.aggregate_id,
        name: event.name,
        head: event.head
      }
    )

    create_record(
      DependencySourceBranchVersionRecord,
      {
        dependency_source_branch_record_id: dsbr.id,
        sha: event.head,
        version_timestamp: event.version_timestamp
      }
    )
  end

  on DependencySourceBranchUpdated do |event|
    update_all_records(
      DependencySourceBranchRecord,
      {
        dependency_source_record_aggregate_id: event.aggregate_id,
        name: event.name
      },
      {
        head: event.head
      }
    )
  end

  on DependencySourceBranchVersionCreated do |event|
    ds_record = get_record!(DependencySourceRecord, {aggregate_id: event.aggregate_id})
    dsb_record = get_record!(DependencySourceBranchRecord, {dependency_source_record_aggregate_id: event.aggregate_id, name: event.name})

    create_record(
      DependencySourceBranchVersionRecord,
      {
        dependency_source_branch_record_id: dsb_record.id,
        sha: event.head,
        version_timestamp: event.version_timestamp
      }
    )
  end

  on DependencySourceBranchVersionUpdated do |event|
    ds_record = get_record!(DependencySourceRecord, {aggregate_id: event.aggregate_id})
    dsb_record = get_record!(DependencySourceBranchRecord, {dependency_source_record_aggregate_id: event.aggregate_id, name: event.name})

    update_all_records(
      DependencySourceBranchVersionRecord,
      {
        dependency_source_branch_record_id: dsb_record.id,
        sha: event.head
      },
      {
        version_timestamp: event.version_timestamp
      }
    )
  end
end