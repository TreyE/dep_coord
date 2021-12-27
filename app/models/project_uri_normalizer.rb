class ProjectUriNormalizer
  def self.normalize(uri)
    if uri.starts_with?("http")
      parsed_uri = URI.parse(uri)
      parsed_uri.path.chomp(".git").delete_prefix("/")
    elsif uri.starts_with?("git@")
      path_part = uri.split(":").last
      path_part.chomp(".git")
    elsif uri.starts_with?("git:")
      parsed_uri = URI.parse(uri)
      parsed_uri.path.chomp(".git").delete_prefix("/")
    else
      uri
    end
  end
end