source 'https://rubygems.org'

ruby '2.7.0'

gem "hanami-api", "0.1.0"
gem "hanami"
gem 'hanami-model', '~> 1.3'
gem 'pg'
gem 'rake'
gem 'rack'
gem 'pry'
gem 'bigdecimal', '1.4.2'
gem 'dry-system', '~> 0.9.0'
gem 'dry-monads', '~> 1.1.0'
gem 'dry-validation'
gem 'oj', '~> 3.10'

group :development do
  # Code reloading
  # See: https://guides.hanamirb.org/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
  gem 'pry'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
end

group :test do
  gem 'rspec'
  gem 'capybara'
end

group :production do
   gem 'puma'
end
