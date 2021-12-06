class BranchVersionRecord < Sequent::ApplicationRecord
  belongs_to :dependency_project_branch_record
  has_many :branch_dependency_records

  delegate :project_name, to: :dependency_project_branch_record

  def branch_name
    dependency_project_branch_record.name
  end
end