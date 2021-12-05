class DependencyProjectProjector < Sequent::Projector
  manages_tables DependencyProjectRecord, DependencyProjectBranchRecord, BranchVersionRecord

  on DependencyProjectCreated do |event|
    create_record(
      DependencyProjectRecord,
      {
        aggregate_id: event.aggregate_id,
        main_branch: event.main_branch
      }
    )
  end

  on DependencyProjectBranchCreated do |event|
    dpbr = create_record(
      DependencyProjectBranchRecord,
      {
        dependency_project_record_aggregate_id: event.aggregate_id,
        name: event.name,
        head: event.sha
      }
    )
    create_record(
      BranchVersionRecord,
      {
        dependency_project_branch_record_id: dpbr.id,
        sha: event.sha
      }
    )
  end

  on BranchVersionCreated do |event|
    dp_record = get_record!(DependencyProjectRecord, {aggregate_id: event.aggregate_id})
    b_record = get_record!(DependencyProjectBranchRecord, {dependency_project_record_aggregate_id: event.aggregate_id, name: event.branch_name})

    create_record(
      BranchVersionRecord,
      {
        dependency_project_branch_record_id: b_record.id,
        sha: event.branch_revision
      }
    )

    update_all_records(
      DependencyProjectBranchRecord,
      {dependency_project_record_aggregate_id: event.aggregate_id, name: event.branch_name},
      {head: event.branch_revision}
    )
  end
end
