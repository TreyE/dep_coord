CREATE TABLE dependency_gem_records%SUFFIX% (
  id BIGSERIAL PRIMARY KEY,
  aggregate_id varchar(1024) NOT NULL,
  name varchar(1024) NOT NULL,
  version varchar(1024) NOT NULL,
  ruby_min_version varchar(1024),
  ruby_max_version varchar(1024)
);

CREATE INDEX dependency_gem_records_aggregate_id%SUFFIX% ON dependency_gem_records%SUFFIX% USING btree (aggregate_id);
