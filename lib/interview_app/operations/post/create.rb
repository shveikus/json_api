module InterviewApp
  module Operations
    module Post
      class Create < Operation
        include ImportRepos[
          post_repo: 'post_repo',
          user_repo: 'user_repo'
        ]

        VALIDATOR = Dry::Validation.JSON do
          required(:title).filled(:str?)
          required(:body).filled(:str?)
          required(:author_login).filled(:str?)
        end

        def call(payload)
          payload = yield VALIDATOR.call(payload).to_either
          user = user_exist?(payload[:author_login])
          payload[:user_id] = user.id
          post = yield persist_post(payload)

          Success(post)
        end

        private

        def persist_post(payload)
          Try(Hanami::Model::UniqueConstraintViolationError) do
            post_repo.create(payload)
          end.to_result
        end

        def user_exist?(login)
          user_repo.already_exist?(login) || user_repo.create( login: login)
        end
      end
    end
  end
end
