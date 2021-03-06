module WebhookProcessors
  class ProjectPush
    attr_reader :sha, :branch, :project_name, :repo_name, :gemfile_uri, :default_branch

    def initialize(payload)
      @sha = payload["after"]
      parse_project_name(payload)
      parse_branch_name(payload)
      parse_repo_name(payload)
      @is_delete_push = false
      if @sha != "0000000000000000000000000000000000000000"
        parse_github_lookup_uri(payload)
        parse_default_branch(payload)
        parse_head_commit_timestamp(payload)
      else
        @is_delete_push = true
      end
    end

    def enqueue
      if @is_branch
        if @is_delete_push
          ProcessBranchDelete.perform_async(
            @project_name,
            @repo_name,
            @branch
          )
        else
          ProcessProjectUpdate.perform_async(
            @project_name,
            @repo_name,
            @default_branch,
            @branch,
            @sha,
            @update_timestamp,
            @gemfile_uri
          )
          end
      end
    end

    private

    def parse_head_commit_timestamp(payload)
      hc_section = payload["head_commit"]
      return if hc_section.blank?
      @update_timestamp = DateTime.iso8601(hc_section["timestamp"])
    end

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
      download_url_value = repo_section["contents_url"]
      return if download_url_value.blank?
      download_url_base = download_url_value.chomp("{+path}")
      @gemfile_uri = "#{download_url_base}Gemfile.lock?ref=#{@sha}"
    end
  end
end