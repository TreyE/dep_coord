class ProcessProjectUpdate
  include Sidekiq::Worker

  def perform(
    project_name,
    repo_name,
    default_branch,
    branch,
    sha,
    gemfile_uri
  )
    command = CreateDependencyProject.create(project_name, repo_name, default_branch)
    Sequent.command_service.execute_commands command
    response = Faraday.get gemfile_uri
    parser = Parsers::GemLockfileParser.new
    results = parser.parse(response.body)
    results = result.select { |r| r.is_a?(BranchDependency) }
    commands = results.map do |res|
      AddBranchDependency.create(
        project_name,
        repo_name,
        branch,
        sha,
        Time.now,
        res
      )
    end
    Sequent.command_service.execute_commands *commands
  end
end