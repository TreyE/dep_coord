class BranchDependencyRecord < Sequent::ApplicationRecord
  belongs_to :branch_version_record

  def git?
    kind == "git"
  end

  def gem?
    kind == "gem"
  end
end