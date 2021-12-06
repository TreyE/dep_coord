module ProjectsHelper
  def latest_branch_link_if_available(branch)
    branch.latest_version ? link_to(branch.latest_version.sha, branch.latest_version) : branch.head
  end
end