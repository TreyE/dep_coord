require 'octokit'

class DependencySourceBaseliner
  attr_reader :project_name, :repo_name, :default_branch
  attr_reader :sha, :branch, :update_timestamp, :contents_url

  def initialize(repo_name, branch_to_baseline)
    @repo_name = repo_name
    @branch = branch_to_baseline
  end

  def baseline!
    query!
    enqueue!
  end

  protected

  def enqueue!
    command = CreateDependencySource.create(@project_name, @repo_name, @default_branch)
    Sequent.command_service.execute_commands command
    branch_command = AddDependencySourceBranch.create(@project_name, @repo_name, @branch, @sha, @update_timestamp)
    Sequent.command_service.execute_commands branch_command
  end

  def query!
    client = OctokitClient.build
    repository = client.repository(@repo_name)
    @project_name = repository.name
    @default_branch = repository.default_branch
    branch_info = client.branch(@repo_name, @branch)
    @sha = branch_info.commit.sha
    @update_timestamp = branch_info.commit.commit.author.date.to_datetime
  end
end