class OutOfDateDependencyRecord < Sequent::ApplicationRecord
end

class OutOfDateDependencyProjector < Sequent::Projector
  manages_tables OutOfDateDependencyRecord
end