require_relative '../../app/sequent/dependency_project'
require_relative '../../app/sequent/dependency_source'
require_relative '../../db/sequent_migrations'
  
Sequent.configure do |config|
 config.migrations_class_name = 'SequentMigrations'
  
 config.command_handlers = [
   DependencyProjectCommandHandler.new,
   DependencySourceCommandHandler.new
 ]
  
 config.event_handlers = [
   DependencyProjectProjector.new,
   DependencySourceProjector.new
 ]

 config.database_config_directory = 'config'
    
 # this is the location of your sql files for your view_schema
 config.migration_sql_files_directory = 'db/sequent'
end
