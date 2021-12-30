require "base64"

class ResolveDependencyGemDependencies
  include Sidekiq::Worker

  def perform(
    aggregate_id,
    name,
    version
  )
    begin
      gem_response = Gems.get("/api/v2/rubygems/#{name}/versions/#{version}")
      data = JSON.parse(gem_response)
      ruby_version = data["ruby_version"]
      if !ruby_version.blank?
        ruby_version_results = RubyConstraintVersion.from_constraint_string(ruby_version)
        if !ruby_version_results.blank?
          command = ResolveDependencyGemRubyVersions.new({
            aggregate_id: aggregate_id,
            min_version: ruby_version_results.min_version,
            max_version: ruby_version_results.max_version
          })
          Sequent.command_service.execute_commands command
        end
      end
    rescue Gems::NotFound
    end
  end
end