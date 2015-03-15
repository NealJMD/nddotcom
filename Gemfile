ruby '2.0.0'

source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'
# use acts_as_tree for categories
gem 'acts_as_tree'

# Use sqlite3 as the database for dev and postgres for heroku
gem 'sqlite3', group: [:development, :test]
gem 'pg', group: :production
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# file attachment
gem 'paperclip'

# admin authentication
gem 'devise'

# user unicorn for server
gem 'unicorn'

# use rspec and spork for tests
group :test do
  gem 'rspec-rails'
  gem 'spork'
  gem 'capybara'
end

group :production do
  gem 'aws-sdk' # store files on S3
  gem 'rails_12factor' # logging and assets for rails on heroku
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

