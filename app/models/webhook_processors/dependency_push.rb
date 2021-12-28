module WebhookProcessors
  class DependencyPush
    def initialize(payload)
      @sha = payload["after"]
      parse_project_name(payload)
      parse_branch_name(payload)
      parse_repo_name(payload)
      parse_default_branch(payload)
      parse_head_commit_timestamp(payload)
    end

    def save!
      if @is_branch
        command = CreateDependencySource.create(@project_name, @repo_name, @default_branch)
        Sequent.command_service.execute_commands command
        branch_command = AddDependencySourceBranch.create(@project_name, @repo_name, @branch, @sha, @update_timestamp)
        Sequent.command_service.execute_commands branch_command
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
  end
end