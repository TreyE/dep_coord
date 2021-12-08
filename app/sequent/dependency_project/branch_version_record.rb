class BranchVersionRecord < Sequent::ApplicationRecord
  belongs_to :dependency_project_branch_record
  has_many :branch_dependency_records

  delegate :project_name, to: :dependency_project_branch_record

  def branch_name
    dependency_project_branch_record.name
  end

  def out_of_date_dependencies
    query_code = <<-SQLCODE
    select 
  pdb.id as dependency_project_branch_record_id,
  bdr.id as branch_dependency_record_id,
  bdr.name as dependency_name,
  bdr.revision as dependency_version,
  dsbr.head as head_version
  from #{BranchDependencyRecord.table_name} bdr
  join #{self.class.table_name} bvr on bdr.branch_version_record_id = bvr.id
  join #{DependencyProjectBranchRecord.table_name} pdb on bvr.dependency_project_branch_record_id = pdb.id
  join #{DependencySourceRecord.table_name} dsr on bdr.name = dsr.name and dsr.remote = bdr.remote and dsr.name = bdr.name
  join #{DependencySourceBranchRecord.table_name} dsbr on dsbr.dependency_source_record_aggregate_id = dsr.aggregate_id and bdr.revision <> dsbr.head
  where bvr.id = $1
    SQLCODE
    result = self.class.connection.exec_query(
      query_code,
      "OUT OF DATE DEPENDENCIES",
      [self.id]
    )
    result_hash = {}
    result.map do |rec|
      result_hash[rec["branch_dependency_record_id"]] = rec
    end
    result_hash
  end
end