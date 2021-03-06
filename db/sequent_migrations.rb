VIEW_SCHEMA_VERSION = 1
  
class SequentMigrations < Sequent::Migrations::Projectors
 def self.version
   VIEW_SCHEMA_VERSION
 end
  
 def self.versions
   {
     '1' => [
       DependencyProjectProjector,
       DependencySourceProjector,
       OutOfDateDependencyProjector,
       DependencyGemProjector
       # List of migrations for version 1
     ],
   }
 end
end
