require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']

source 'http://rubygems.org'

gem 'rails', '3.1.1'
gem 'paperclip'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
gem 'ruby-debug19', :require => 'ruby-debug', :group => [:development, :test]

# install a Javascript runtime for linux
if HOST_OS =~ /linux/i
  gem 'therubyracer', '>= 0.9.8'
end

gem "haml", ">= 3.1.2"
gem "haml-rails", ">= 0.3.4", :group => :development
gem "rspec-rails", ">= 2.8.0.rc1", :group => [:development, :test]
gem "factory_girl_rails", ">= 1.4.0", :group => [:development, :test]
gem "cucumber-rails", ">= 1.2.0", :group => :test
gem "capybara", ">= 1.1.2", :group => :test
gem "database_cleaner", ">= 0.7.0", :group => :test
gem "launchy", ">= 2.0.5", :group => :test
gem 'spork', '>=0.9.0.rc9', :group => [:development, :test]
gem "guard", ">= 0.6.2", :group => [:development, :test]
case HOST_OS
  when /darwin/i
    gem 'rb-fsevent', :group => :development
    gem 'growl', :group => :development
  when /linux/i
    gem 'libnotify', :group => :development
    gem 'rb-inotify', :group => :development
end
gem "guard-bundler", ">= 0.1.3", :group => :development
gem "guard-cucumber", ">= 0.6.1", :group => [:development, :test]
gem "guard-spork", :group => [:development, :test]
gem "rails-footnotes", ">= 3.7", :group => :development
gem "bootstrap-sass"
