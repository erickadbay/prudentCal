require 'simplecov' if ENV["COVERAGE"]
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rspec'
require 'capybara/rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  SimpleCov.start do
  add_filter 'test/'
  add_filter 'config/'
  add_filter 'vendor/'
  add_filter 'mod_db.rb'  # One use methods for modifying the database

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Views', 'app/views'
  add_group 'Library', 'lib/my_lib'
end if ENV["COVERAGE"]
end
