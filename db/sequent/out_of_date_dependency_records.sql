create view out_of_date_dependency_records%SUFFIX% as
  select 
    pdb.id as dependency_project_branch_record_id,
    bdr.id as branch_dependency_record_id,
    bvr.id as branch_version_record_id,
    bdr.name as dependency_name,
    bdr.revision as dependency_version,
    dsbr.head as head_version
    from branch_dependency_records%SUFFIX% bdr
    join branch_version_records%SUFFIX% bvr on bdr.branch_version_record_id = bvr.id
    join dependency_project_branch_records%SUFFIX% pdb on bvr.dependency_project_branch_record_id = pdb.id
    join dependency_source_records%SUFFIX% dsr on bdr.name = dsr.name and dsr.remote = bdr.remote and dsr.name = bdr.name
    join dependency_source_branch_records%SUFFIX% dsbr on dsbr.dependency_source_record_aggregate_id = dsr.aggregate_id and bdr.revision <> dsbr.head;