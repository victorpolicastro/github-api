# frozen_string_literal: true

source('https://rubygems.org')
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby('2.7.1')

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem('rails', '~> 6.0.3', '>= 6.0.3.2')
# Use postgresql as the database for Active Record
gem('pg', '>= 0.18', '< 2.0')
# Use Puma as the app server
gem('puma', '~> 4.1')
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem('bootsnap', '>= 1.4.2', require: false)

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

# A ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard.
gem('jwt')

# bcrypt-ruby is a Ruby binding for the OpenBSD bcrypt() password hashing algorithm,
# allowing you to easily store a secure hash of your users' passwords.
gem('bcrypt')

# Simple HTTP and REST client for Ruby, inspired by microframework syntax for specifying actions.
gem('rest-client')

# Simple Rails app configuration
gem('figaro')

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem('byebug', platforms: %i[mri mingw x64_mingw])
  # A Ruby static code analyzer and formatter, based on the community Ruby style guide.
  gem('rubocop')
  # An extension of RuboCop focused on code performance checks.
  gem('rubocop-performance')
  # A RuboCop extension focused on enforcing Rails best practices and coding conventions.
  gem('rubocop-rails')
  # Code style checking for RSpec files
  gem('rubocop-rspec')
  # RSpec for Rails 5+
  gem('rspec-rails')
  # Factory Bot <3 Rails
  gem('factory_bot_rails')
  # A library for generating fake data such as names, addresses, and phone numbers.
  gem('faker')
  # Library for stubbing and setting expectations on HTTP requests in Ruby.
  gem('webmock')
end

group :development do
  # The Listen gem listens to file modifications and notifies you about the changes.
  gem('listen', '~> 3.2')
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem('spring')
  # Makes Spring watch the filesystem for changes using Listen rather than by polling the filesystem.
  gem('spring-watcher-listen', '~> 2.0.0')
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem('tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby])
