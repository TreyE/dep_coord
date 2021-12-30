class DependencyGemCreated < Sequent::Event
  attrs({
    name: String,
    version: String
  })
end

class DependencyGemRubyVersionsResolved < Sequent::Event
  attrs({
    min_version: String,
    max_version: String
  })
end