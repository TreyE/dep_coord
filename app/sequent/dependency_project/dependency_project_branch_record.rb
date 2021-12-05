class DependencyProjectBranchRecord < Sequent::ApplicationRecord
  belongs_to :dependency_project_record, class_name: "DependencyProjectRecord", primary_key: "aggregate_id", foreign_key: "dependency_project_record_aggregate_id"
  has_many :branch_version_records
end
