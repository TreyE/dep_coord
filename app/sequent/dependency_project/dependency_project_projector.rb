class DependencyProjectProjector < Sequent::Projector
  manages_tables DependencyProjectRecord

  on DependencyProjectCreated do |event|
    create_record(
      DependencyProjectRecord,
      {
        aggregate_id: event.aggregate_id,
        main_branch: event.main_branch
      }
    )
  end
end
