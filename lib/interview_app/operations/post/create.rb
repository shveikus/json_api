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
          required(:login).filled(:str?)
          optional(:ip).filled(:str?)
        end

        def call(payload)
          payload = yield VALIDATOR.call(payload).to_either
          user = yield user_find_or_create(payload)
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

        def user_find_or_create(payload)
          Try(Hanami::Model::UniqueConstraintViolationError) do
            user_params = { login: payload[:login], ip: payload.fetch(:ip, '0.0.0.0') }
            user_repo.already_exist?(user_params[:login]) || user_repo.create(user_params)
          end.to_result
        end
      end
    end
  end
end
