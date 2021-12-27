class DependencySourceRecord < Sequent::ApplicationRecord
  has_many :dependency_source_branch_records, class_name: "DependencySourceBranchRecord", primary_key: "aggregate_id", foreign_key: "dependency_source_record_aggregate_id"
end