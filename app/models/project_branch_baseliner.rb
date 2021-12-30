require 'octokit'

class ProjectBranchBaseliner
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
    ProcessProjectUpdate.perform_async(
      @project_name,
      @repo_name,
      @default_branch,
      @branch,
      @sha,
      @update_timestamp,
      @contents_url
    )
  end

  def query!
    client = Octokit::Client.new
    repository = client.repository(@repo_name)
    @project_name = repository.name
    @default_branch = repository.default_branch
    branch_info = client.branch(@repo_name, @branch)
    @sha = branch_info.commit.sha
    @update_timestamp = branch_info.commit.commit.author.date
    contents_url_value = repository.contents_url
    download_url_base = contents_url_value.chomp("{+path}")
    @contents_url = "#{download_url_base}Gemfile.lock?ref=#{@sha}"
  end
end