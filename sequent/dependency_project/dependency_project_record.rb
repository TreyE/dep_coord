class DependencyProjectRecord < Sequent::ApplicationRecord
  has_many :dependency_project_branch_records, class_name: "DependencyProjectBranchRecord", primary_key: "aggregate_id", foreign_key: "dependency_project_record_aggregate_id"
end