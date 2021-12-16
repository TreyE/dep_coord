class ProjectUriNormalizer
  def self.normalize(uri)
    if uri.starts_with?("http")
      parsed_uri = URI.parse(uri)
      parsed_uri.path.chomp(".git").delete_prefix("/")
    else
      path_part = uri.split(":").last
      path_part.chomp(".git")
    end
  end
end