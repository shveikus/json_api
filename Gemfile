source 'https://rubygems.org'

ruby '2.7.0'

gem 'bigdecimal', '1.4.2'
gem 'dry-monads', '~> 1.1.0'
gem 'dry-system', '~> 0.9.0'
gem 'dry-validation'
gem 'faker'
gem 'hanami'
gem 'hanami-api', '0.1.1'
gem 'hanami-model', '~> 1.3'
gem 'httparty'
gem 'oj', '~> 3.10'
gem 'pg'
gem 'pg'
gem 'pry'
gem 'rack'
gem 'rake'
gem 'require_all'

group :development do
  # Code reloading
  # See: https://guides.hanamirb.org/projects/code-reloading
  gem 'hanami-webconsole'
  gem 'pry'
  gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
end

group :test do
  gem 'capybara'
  gem 'rspec'
end

group :production do
  gem 'puma'
end
