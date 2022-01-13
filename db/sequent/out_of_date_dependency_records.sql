create view out_of_date_dependency_records%SUFFIX% as
  select 
    pdb.id as dependency_project_branch_record_id,
    bdr.id as branch_dependency_record_id,
    bvr.id as branch_version_record_id,
    bvr.version_timestamp as branch_version_update_timestamp,
    bdr.name as dependency_name,
    bdr.revision as dependency_version,
    dsbvr.version_timestamp as dependency_source_update_timestamp,
    dsbvr.sha as head_version
    from branch_dependency_records%SUFFIX% bdr
    join branch_version_records%SUFFIX% bvr on bdr.branch_version_record_id = bvr.id
    join dependency_project_branch_records%SUFFIX% pdb on bvr.dependency_project_branch_record_id = pdb.id
    join dependency_source_records%SUFFIX% dsr on bdr.name = dsr.name and dsr.remote = bdr.remote and dsr.name = bdr.name
    join dependency_source_branch_records%SUFFIX% dsbr on dsbr.dependency_source_record_aggregate_id = dsr.aggregate_id and dsbr.name = bdr.branch
	join dependency_source_branch_version_records%SUFFIX% dsbvr on dsbvr.dependency_source_branch_record_id = dsbr.id and dsbvr.version_timestamp <= bvr.version_timestamp and dsbvr.sha <> bdr.revision
	left outer join dependency_source_branch_version_records%SUFFIX% dsbvr2 on dsbvr.dependency_source_branch_record_id = dsbvr2.dependency_source_branch_record_id and dsbvr2.version_timestamp > dsbvr.version_timestamp and dsbvr2.id is null;