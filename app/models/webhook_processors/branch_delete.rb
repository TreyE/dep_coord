module WebhookProcessors
  class BranchDelete
    attr_reader :branch, :project_name, :repo_name

    def initialize(payload)
      parse_project_name(payload)
      parse_branch_name(payload)
      parse_repo_name(payload)
    end

    def enqueue
      if @is_branch
        ProcessBranchDelete.perform_async(
          @project_name,
          @repo_name,
          @branch
        )
      end
    end

    private

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