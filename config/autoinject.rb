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
