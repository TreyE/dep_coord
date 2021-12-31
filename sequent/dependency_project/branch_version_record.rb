class BranchVersionRecord < Sequent::ApplicationRecord
  belongs_to :dependency_project_branch_record
  has_many :branch_dependency_records
  has_many :out_of_date_dependency_records
  has_one :branch_version_ruby_version_record

  delegate :project_name, to: :dependency_project_branch_record

  def branch_name
    dependency_project_branch_record.name
  end

  def out_of_date_dependencies
    lookup_hash = {}
    out_of_date_dependency_records.each do |rec|
      lookup_hash[rec.branch_dependency_record_id] = rec
    end
    lookup_hash
  end
end