module WebhookProcessors
  class ProjectPush
    attr_reader :sha, :branch, :project_name, :repo_name, :gemfile_uri, :default_branch

    def initialize(payload)
      @sha = payload["after"]
      parse_project_name(payload)
      parse_branch_name(payload)
      parse_repo_name(payload)
      parse_github_lookup_uri(payload)
      parse_default_branch(payload)
    end

    def enqueue
      if @is_branch
        ProcessProjectUpdate.perform_async(
          @project_name,
          @repo_name,
          @default_branch,
          @branch,
          @sha,
          @gemfile_uri
        )
      end
    end

    private

    def parse_default_branch(payload)
      repo_section = payload["repository"]
      return if repo_section.blank?
      @default_branch = repo_section["default_branch"]
    end

    def parse_project_name(payload)
      repo_section = payload["repository"]
      return if repo_section.blank?
      @project_name = repo_section["name"]
    end

    def parse_branch_name(payload)
      ref = payload["ref"]
      @is_branch = ref.starts_with?("refs/heads")
      if @is_branch
        @branch = ref.delete_prefix("refs/heads/")
      end
    end

    def parse_repo_name(payload)
      repo_section = payload["repository"]
      return if repo_section.blank?
      @repo_name = repo_section["full_name"]
    end

    def parse_github_lookup_uri(payload)
      repo_section = payload["repository"]
      return if repo_section.blank?
      download_url_value = repo_section["downloads_url"]
      return if download_url_value.blank?
      @gemfile_uri = "#{download_url_value}/#{@sha}/Gemfile.lock"
    end
  end
end