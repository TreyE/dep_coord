CREATE VIEW branch_version_ruby_version_records%SUFFIX% AS
select max(dgr.ruby_min_version) as ruby_min_version,
       min(dgr.ruby_max_version) as ruby_max_version,
	   bdr.branch_version_record_id as branch_version_record_id
  from dependency_gem_records%SUFFIX% dgr
  join branch_dependency_records%SUFFIX% bdr on bdr.kind = 'gem' and
    dgr.name = bdr.name and dgr.version = bdr.version_constraint and 
	(dgr.ruby_min_version is not null or dgr.ruby_max_version is not null)
  group by bdr.branch_version_record_id;