class BranchVersionRubyVersionRecord < Sequent::ApplicationRecord
  belongs_to :branch_version_record

  def max_ruby_version_number
    format_version(ruby_max_version)
  end

  def min_ruby_version_number
    format_version(ruby_min_version)
  end

  def minimum_gems_for_version
    return [] if ruby_min_version.blank?
    query_string = <<-SQLCODE
    SELECT * FROM
      #{DependencyGemRecord.table_name} dgr
      JOIN #{BranchDependencyRecord.table_name} bdr
      ON bdr.kind = 'gem' AND dgr.name = bdr.name AND
        dgr.version = bdr.version_constraint
      WHERE
        bdr.branch_version_record_id = ? AND
        dgr.ruby_min_version = ?
    SQLCODE
    DependencyGemRecord.find_by_sql([query_string, self.branch_version_record_id, ruby_min_version])
  end

  def maximum_gems_for_version
    return [] if ruby_max_version.blank?
    query_string = <<-SQLCODE
    SELECT * FROM
      #{DependencyGemRecord.table_name} dgr
      JOIN #{BranchDependencyRecord.table_name} bdr
      ON bdr.kind = 'gem' AND dgr.name = bdr.name AND
        dgr.version = bdr.version_constraint
      WHERE
        bdr.branch_version_record_id = ? AND
        dgr.ruby_max_version = ?
    SQLCODE
    DependencyGemRecord.find_by_sql([query_string, self.branch_version_record_id, ruby_max_version])
  end

  private

  def format_version(version_string)
    RubyConstraintVersion.stored_string_to_version_string(version_string)
  end
end