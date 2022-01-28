require "base64"

class ProcessBranchDelete
  include Sidekiq::Worker

  def perform(
    project_name,
    repo_name,
    branch
  )
    delete_command = DeleteProjectBranch.create(
      project_name,
      repo_name,
      branch
    )
    Sequent.command_service.execute_commands delete_command
  end
end