ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

require 'sequent_db_prepper'
begin
  SequentDbPrepper.new.prepare
rescue Exception => e
  puts e.to_s.strip
  exit 1
end

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  parallelize_setup do
    begin
      SequentDbPrepper.new.prepare
    rescue Exception => e
      puts e.to_s.strip
      exit 1
    end
  end
end
