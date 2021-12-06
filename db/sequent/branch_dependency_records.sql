CREATE TABLE branch_dependency_records%SUFFIX% (
  id BIGSERIAL PRIMARY KEY,
  branch_version_record_id BIGSERIAL NOT NULL,
  name varchar(1024) NOT NULL,
  kind varchar(512) NOT NULL,
  version_constraint varchar(512),
  revision varchar(1024),
  branch varchar(1024),
  remote varchar(1024)
);

CREATE INDEX bdr_bvr_id%SUFFIX% ON branch_dependency_records%SUFFIX% USING btree (branch_version_record_id);
CREATE INDEX bdr_name%SUFFIX% ON branch_dependency_records%SUFFIX% USING btree (name);
