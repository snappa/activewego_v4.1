source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', group: :development

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'

# Gems added from Rails Tutorial
gem 'bootstrap-sass', '3.1.1.0'

gem 'faker', '1.3.0'
gem 'will_paginate', '3.0.5'
gem 'bootstrap-will_paginate', '0.0.10'

group :development, :test do
  gem 'rspec-rails', '2.14.2'
  # The following optional lines are part of the advanced setup.
  gem 'guard-rspec', '4.2.8'
  gem 'spork-rails', '4.0.0'
  gem 'guard-spork', '1.5.1'
  gem 'childprocess', '0.5.2'
end

group :production, :development do
  gem 'pg', '0.17.1'
end

group :development do
  gem 'rack-mini-profiler'
end

group :production do
  gem 'rails_12factor', '0.0.2'
end

# WDS: Add if we use Firebase
#gem 'firebase_token_generator'

group :test do
  gem 'selenium-webdriver', '2.41.0'
  gem 'capybara', '2.2.1'
  gem 'factory_girl_rails', '4.4.1'
  gem 'cucumber-rails', '1.4.0', :require => false
  gem 'database_cleaner', '1.2.0'

  # Uncomment this line on OS X.
  # gem 'growl', '1.0.3'

  # Uncomment these lines on Linux.
  # gem 'libnotify', '0.8.2'

  # Uncomment these lines on Windows.
  # gem 'rb-notifu', '0.0.4'
  # gem 'win32console', '1.3.2'
end

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

