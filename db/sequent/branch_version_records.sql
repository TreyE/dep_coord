CREATE TABLE branch_version_records%SUFFIX% (
  id BIGSERIAL PRIMARY KEY,
  dependency_project_branch_record_id BIGSERIAL NOT NULL,
  sha varchar(1024) NOT NULL,
  version_timestamp timestamp without time zone NOT NULL
);

CREATE INDEX bvr_dpbr_id%SUFFIX% ON branch_version_records%SUFFIX% USING btree (dependency_project_branch_record_id);
CREATE INDEX bvr_dpbr_sha%SUFFIX% ON branch_version_records%SUFFIX% USING btree (sha);
