class OctokitClient
  def self.build
    access_token = ENV['GITHUB_ACCESS_TOKEN']
    if access_token.blank?
      Octokit::Client.new
    else
      Octokit::Client.new(access_token: access_token)
    end
  end
end