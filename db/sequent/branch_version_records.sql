CREATE TABLE branch_version_records%SUFFIX% (
  id BIGSERIAL PRIMARY KEY,
  dependency_project_branch_record_id BIGSERIAL NOT NULL,
  sha varchar(1024) NOT NULL,
  version_timestamp timestamp without time zone NOT NULL,
  CONSTRAINT bvr_dpbr_id_fk_%SUFFIX% FOREIGN KEY (dependency_project_branch_record_id)
  REFERENCES dependency_project_branch_records%SUFFIX% (id)
);

CREATE INDEX bvr_dpbr_id%SUFFIX% ON branch_version_records%SUFFIX% USING btree (dependency_project_branch_record_id);
CREATE INDEX bvr_dpbr_sha%SUFFIX% ON branch_version_records%SUFFIX% USING btree (sha);

