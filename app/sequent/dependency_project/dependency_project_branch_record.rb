class DependencyProjectBranchRecord < Sequent::ApplicationRecord
  belongs_to :dependency_project_record, class_name: "DependencyProjectRecord", primary_key: "aggregate_id", foreign_key: "dependency_project_record_aggregate_id"
  has_many :branch_version_records

  def latest_version
    branch_version_records.detect { |bvr| bvr.sha == self.head }
  end

  def project_name
    dependency_project_record.name
  end
end
