# frozen_string_literal: true

require 'dotenv/load'
require 'require_all'
require_relative './autoinject'
require 'bundler/setup'
require 'hanami/api'
require 'hanami/model'
require 'hanami/model/sql'
require_all 'lib'
require 'hanami/middleware/body_parser'
require 'dry/monads/result'
require 'dry/monads/try'
require 'dry/monads/do'
require 'dry/monads/do/all'
require 'dry/validation'
require 'dry/system/container'
require 'oj'
require 'pry'
require_relative '../app'

Hanami::Model.configure do
  adapter :sql, ENV['DB_URL']
end.load!
