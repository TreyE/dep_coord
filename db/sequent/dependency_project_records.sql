CREATE TABLE dependency_project_records%SUFFIX% (
  id BIGSERIAL PRIMARY KEY,
  aggregate_id varchar(1024) NOT NULL,
  main_branch varchar(1024) NOT NULL
);

CREATE INDEX ehs_id_aggregate_id%SUFFIX% ON dependency_project_records%SUFFIX% USING btree (aggregate_id);
