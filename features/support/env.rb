
require 'rubygems'
require 'spork'
 
Spork.prefork do
  require 'cucumber/rails'
	require 'ruby-debug'

  Capybara.default_selector = :css
end
 
Spork.each_run do

	DatabaseCleaner.strategy = :transaction

end
