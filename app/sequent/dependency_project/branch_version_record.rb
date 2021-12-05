class BranchVersionRecord < Sequent::ApplicationRecord
  belongs_to :dependency_project_branch_record
end