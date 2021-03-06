CREATE TABLE dependency_project_branch_records%SUFFIX% (
  id BIGSERIAL PRIMARY KEY,
  dependency_project_record_aggregate_id varchar(1024) NOT NULL,
  name varchar(1024) NOT NULL,
  head varchar(1024) NOT NULL,
  CONSTRAINT dpbr_dpr_aggregate_id_fk%SUFFIX% FOREIGN KEY (dependency_project_record_aggregate_id)
  REFERENCES dependency_project_records%SUFFIX% (aggregate_id)
);

CREATE INDEX dpbr_dpr_aggregate_id%SUFFIX% ON dependency_project_branch_records%SUFFIX% USING btree (dependency_project_record_aggregate_id);
CREATE INDEX dpbr_name%SUFFIX% ON dependency_project_branch_records%SUFFIX% USING btree (name);
