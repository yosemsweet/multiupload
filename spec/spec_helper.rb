require 'rubygems'
require 'spork'
 
Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
	require 'ruby-debug'
 	require 'factory_girl_rails'

  RSpec.configure do |config|
    config.use_transactional_fixtures = true
  	config.fixture_path = "#{::Rails.root}/spec/fixtures"
  end
  
end
 
Spork.each_run do
	FactoryGirl.reload
	Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
end

