class DependencyGemWorkflow < Sequent::Workflow
  on DependencyGemCreated do |event|
    after_commit do
      ResolveDependencyGemDependencies.perform_async(
        event.aggregate_id,
        event.name,
        event.version
      )
    end
  end
end