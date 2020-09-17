# frozen_string_literal: true

require 'dry/monads/result'
require 'dry/monads/try'
require 'dry/monads/do'
require 'dry/monads/do/all'
require 'dry/validation'
require 'dry/system/container'

module InterviewApp
  class Operation
    include Dry::Monads::Try::Mixin
    include Dry::Monads::Result::Mixin
    include Dry::Monads::Do::All

    Dry::Validation.load_extensions(:monads)

    def call(*)
      raise NotImplementedError
    end
  end
end
