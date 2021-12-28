require "base64"

class ProcessProjectUpdate
  include Sidekiq::Worker

  def perform(
    project_name,
    repo_name,
    default_branch,
    branch,
    sha,
    update_timestamp,
    gemfile_uri
  )
    command = CreateDependencyProject.create(project_name, repo_name, default_branch)
    Sequent.command_service.execute_commands command
    response = Faraday.get gemfile_uri
    content_data = JSON.parse(response.body)
    content_b64 = content_data["content"]
    decoded_data = Base64.decode64(content_b64)
    parser = Parsers::GemLockfileParser.new
    result = parser.parse(decoded_data)
    results = result.select { |r| r.is_a?(BranchDependency) }
    commands = results.map do |res|
      AddBranchDependency.create(
        project_name,
        repo_name,
        branch,
        sha,
        update_timestamp,
        res
      )
    end
    Sequent.command_service.execute_commands *commands
  end
end