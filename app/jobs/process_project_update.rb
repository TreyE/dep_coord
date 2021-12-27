class ProcessProjectUpdate
  include Sidekiq::Worker

  def perform(project_name, repo_name, default_branch, sha, gemfile_uri)
    command = CreateDependencyProject.create(project_name,repo_name, default_branch)
    Sequent.command_service.execute_commands command
  end
end