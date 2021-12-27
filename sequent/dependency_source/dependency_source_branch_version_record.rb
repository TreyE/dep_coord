class DependencySourceBranchVersionRecord < Sequent::ApplicationRecord
  belongs_to :dependency_source_branch_record, class_name: "DependencySourceBranchRecord"
end