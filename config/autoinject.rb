require 'dry/system/container'

class ContainerRepos < Dry::System::Container
  extend Dry::Container::Mixin

  register('user_repo', memoize: true) do
    UserRepository.new
  end

  register('post_repo', memoize: true) do
    PostRepository.new
  end
end

ContainerRepos.register(:current_time, memoize: true) { -> { Time.now } }

ImportRepos = ContainerRepos.injector

require './lib/interview_app/operation'
require './lib/interview_app/operations/post/create'
require './lib/interview_app/operations/post/vote'

class ContainerOperations < Dry::System::Container
  extend Dry::Container::Mixin

  register('operations_post_create', memoize: true) do
    InterviewApp::Operations::Post::Create.new
  end

  register('operations_post_vote', memoize: true) do
    InterviewApp::Operations::Post::Vote.new
  end
end

ContainerOperations.register(:current_time, memoize: true) { -> { Time.now } }

ImportOperations = ContainerOperations.injector
