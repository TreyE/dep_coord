CREATE TABLE dependency_source_branch_records%SUFFIX% (
  id BIGSERIAL PRIMARY KEY,
  dependency_source_record_aggregate_id varchar(1024) NOT NULL,
  name varchar(1024) NOT NULL,
  head varchar(1024) NOT NULL,
  CONSTRAINT dsbr_dsr_aggregate_id_fk%SUFFIX% FOREIGN KEY (dependency_source_record_aggregate_id)
  REFERENCES dependency_source_records%SUFFIX% (aggregate_id)
);

CREATE INDEX dsbr_dsr_aggregate_id%SUFFIX% ON dependency_source_branch_records%SUFFIX% USING btree (dependency_source_record_aggregate_id);
CREATE INDEX dsbr_name%SUFFIX% ON dependency_source_branch_records%SUFFIX% USING btree (name);
