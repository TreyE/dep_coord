require_relative '../../sequent/dependency_project'
require_relative '../../sequent/dependency_source'
require_relative '../../sequent/out_of_date_dependency'
require_relative '../../sequent/dependency_gem'
require_relative '../../db/sequent_migrations'

Sequent.configure do |config|
 config.migrations_class_name = 'SequentMigrations'

 config.command_handlers = [
   DependencyProjectCommandHandler.new,
   DependencySourceCommandHandler.new,
   DependencyGemCommandHandler.new
 ]
  
 config.event_handlers = [
   DependencyProjectProjector.new,
   DependencySourceProjector.new,
   OutOfDateDependencyProjector.new,
   DependencyProjectWorkflow.new,
   DependencyGemProjector.new,
   DependencyGemWorkflow.new
 ]

 config.database_config_directory = 'config'
    
 # this is the location of your sql files for your view_schema
 config.migration_sql_files_directory = 'db/sequent'
end
