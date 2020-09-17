# frozen_string_literal: true
require_relative './autoinject'

require "bundler/setup"
require "hanami/api"
require 'hanami/model'
require 'hanami/model/sql'
require 'pry'
Dir["./lib/*/*.rb"].each {|file| require file }
Dir["./lib/*/*/*.rb"].each {|file| require file }
Dir["./lib/*/*/*/*.rb"].each {|file| require file }
require "hanami/middleware/body_parser"
require 'dry/monads/result'
require 'dry/monads/try'
require 'dry/monads/do'
require 'dry/monads/do/all'
require 'dry/validation'
require 'dry/system/container'
require 'oj'


class App < Hanami::API
include Dry::Monads::Result::Mixin
use Hanami::Middleware::BodyParser, :json
  include ImportOperations[
    operation: 'operations_post_create'
  ]

  post "/api/v1/post" do
    result = InterviewApp::Operations::Post::Create.new.call params

    case result
    when Success
      ::Oj.dump(result.success.to_h)
    when Failure
      ::Oj.dump(result.failure)
    end
  end

  post "/api/v1/post/vote" do
    result = InterviewApp::Operations::Post::Vote.new.call params

    case result
    when Success
      ::Oj.dump(result.success.to_h)
    when Failure
      ::Oj.dump(result.failure)
    end
  end
end

Hanami::Model.configure do
  adapter :sql, 'postgresql://postgres:postgres@localhost/interview_app_production'
end.load!

