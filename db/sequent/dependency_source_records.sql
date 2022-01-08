CREATE TABLE dependency_source_records%SUFFIX% (
  id BIGSERIAL PRIMARY KEY,
  aggregate_id varchar(1024) UNIQUE NOT NULL,
  name varchar(1024) NOT NULL,
  main_branch varchar(1024) NOT NULL,
  remote varchar(1024) NOT NULL
);

CREATE INDEX dependency_source_records_aggregate_id%SUFFIX% ON dependency_source_records%SUFFIX% USING btree (aggregate_id);
CREATE INDEX dependency_source_records_name%SUFFIX% ON dependency_source_records%SUFFIX% USING btree (name);
