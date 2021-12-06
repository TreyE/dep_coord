class BranchVersionRecord < Sequent::ApplicationRecord
  belongs_to :dependency_project_branch_record
  has_many :branch_dependency_records
end