class CreateDependencyGem < Sequent::Command
  attrs({
    name: String,
    version: String
  })

  def self.create(name, version)
    aggregate_id = "#{name}__#{version}"
    self.new({
      name: name,
      version: version,
      aggregate_id: aggregate_id
    })
  end
end

class ResolveDependencyGemRubyVersions < Sequent::Command
  attrs({
    min_version: String,
    max_version: String
  })
end