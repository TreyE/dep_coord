class BranchDependency < Sequent::ValueObject
  attrs({
    name: String,
    gem: GemBranchDependency,
    git: GitBranchDependency
  })

  def git?
    !git.blank?
  end

  def gem?
    !gem.blank?
  end
end
