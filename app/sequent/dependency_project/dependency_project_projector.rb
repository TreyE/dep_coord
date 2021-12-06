class DependencyProjectProjector < Sequent::Projector
  manages_tables DependencyProjectRecord, DependencyProjectBranchRecord, BranchVersionRecord, BranchDependencyRecord

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

  on BranchDependencyCreated do |event|
    dp_record = get_record!(DependencyProjectRecord, {aggregate_id: event.aggregate_id})
    b_record = get_record!(DependencyProjectBranchRecord, {dependency_project_record_aggregate_id: event.aggregate_id, name: event.branch_name})
    bv_record = get_record!(BranchVersionRecord, {dependency_project_branch_record_id: b_record.id, sha: event.branch_revision})

    if event.branch_dependency.git?
      create_record(
        BranchDependencyRecord,
        {
          branch_version_record_id: bv_record.id,
          kind: "git",
          name: event.branch_dependency.name,
          revision: event.branch_dependency.git.revision,
          branch: event.branch_dependency.git.branch,
          remote: event.branch_dependency.git.remote,
          version_constraint: event.branch_dependency.git.version_constraint
        }
       )
    elsif event.branch_dependency.gem?
      create_record(
        BranchDependencyRecord,
        {
          branch_version_record_id: bv_record.id,
          kind: "gem",
          name: event.branch_dependency.name,
          version_constraint: event.branch_dependency.gem.version_constraint
        }
       )
    end
  end

  on BranchDependencyUpdated do |event|
    dp_record = get_record!(DependencyProjectRecord, {aggregate_id: event.aggregate_id})
    b_record = get_record!(DependencyProjectBranchRecord, {dependency_project_record_aggregate_id: event.aggregate_id, name: event.branch_name})
    bv_record = get_record!(BranchVersionRecord, {dependency_project_branch_record_id: b_record.id, sha: event.branch_revision})

    if event.branch_dependency.git?
      update_all_records(
        BranchDependencyRecord,
        {
          branch_version_record_id: bv_record.id,
          name: event.branch_dependency.name
        },
        {
          kind: "git",
          name: event.branch_dependency.name,
          revision: event.branch_dependency.git.revision,
          branch: event.branch_dependency.git.branch,
          remote: event.branch_dependency.git.remote,
          version_constraint: event.branch_dependency.git.version_constraint
        }
       )
    elsif event.branch_dependency.gem?
      update_all_records(
        BranchDependencyRecord,
        {
          branch_version_record_id: bv_record.id,
          name: event.branch_dependency.name
        },
        {
          kind: "gem",
          version_constraint: event.branch_dependency.gem.version_constraint,
          revision: nil,
          branch: nil,
          remote: nil
        }
       )
    end
  end
end
