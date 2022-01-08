CREATE TABLE branch_dependency_records%SUFFIX% (
  id BIGSERIAL PRIMARY KEY,
  branch_version_record_id BIGSERIAL NOT NULL,
  name varchar(1024) NOT NULL,
  kind varchar(512) NOT NULL,
  version_constraint varchar(512),
  revision varchar(1024),
  branch varchar(1024),
  remote varchar(1024),
  CONSTRAINT bdr_bvr_id_fk%SUFFIX% FOREIGN KEY (branch_version_record_id)
  REFERENCES branch_version_records%SUFFIX% (id)
);

CREATE INDEX bdr_bvr_id%SUFFIX% ON branch_dependency_records%SUFFIX% USING btree (branch_version_record_id);
CREATE INDEX bdr_name%SUFFIX% ON branch_dependency_records%SUFFIX% USING btree (name);
CREATE INDEX bdr_kind%SUFFIX% ON branch_dependency_records%SUFFIX% USING btree (kind);
CREATE INDEX bdr_revision%SUFFIX% ON branch_dependency_records%SUFFIX% USING btree (revision);
CREATE INDEX bdr_branch%SUFFIX% ON branch_dependency_records%SUFFIX% USING btree (branch);
