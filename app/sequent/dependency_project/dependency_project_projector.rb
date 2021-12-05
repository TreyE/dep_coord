class DependencyProjectProjector < Sequent::Projector
  manages_tables DependencyProjectRecord, DependencyProjectBranchRecord

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
    create_record(
      DependencyProjectBranchRecord,
      {
        dependency_project_record_aggregate_id: event.aggregate_id,
        name: event.name,
        head: event.sha
      }
    )
  end
end
