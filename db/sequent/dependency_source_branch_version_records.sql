CREATE TABLE dependency_source_branch_version_records%SUFFIX% (
  id BIGSERIAL PRIMARY KEY,
  dependency_source_branch_record_id BIGSERIAL NOT NULL,
  sha varchar(1024) NOT NULL,
  version_timestamp timestamp without time zone NOT NULL,
  CONSTRAINT dsbvr_dsbr_id_fk%SUFFIX% FOREIGN KEY (dependency_source_branch_record_id)
  REFERENCES dependency_source_branch_records%SUFFIX% (id)
);

CREATE INDEX dsbvr_dsbr_id%SUFFIX% ON dependency_source_branch_version_records%SUFFIX% USING btree (dependency_source_branch_record_id);
CREATE INDEX dsbvr_sha%SUFFIX% ON dependency_source_branch_version_records%SUFFIX% USING btree (sha);
