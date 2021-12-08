class DependencySourceBranchRecord < Sequent::ApplicationRecord
  belongs_to :dependency_source_record, class_name: "DependencySourceRecord", primary_key: "aggregate_id", foreign_key: "dependency_source_record_aggregate_id"
end