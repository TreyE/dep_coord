class BranchVersionRubyVersionRecord < Sequent::ApplicationRecord
  belongs_to :branch_version_record

  def max_ruby_version_number
    format_version(ruby_max_version)
  end

  def min_ruby_version_number
    format_version(ruby_min_version)
  end

  private

  def format_version(version_string)
    RubyConstraintVersion.stored_string_to_version_string(version_string)
  end
end