module InterviewApp
  module Operations
    module Post
      class Vote < Operation
        include ImportRepos[
          post_repo: 'post_repo'
        ]

        VALIDATOR = Dry::Validation.JSON do
          required(:user_rate).filled(:int?, lt?: 6, gt?: 0)
          required(:post_id).filled(:int?)
        end

        def call(payload)
          payload = yield VALIDATOR.call(payload).to_either
          post = yield calculate_and_update_post_avg_rating(payload)

          Success({ avg_rating: post.avg_rating })
        end

        private

        # locking row due to database concurency issues
        def calculate_and_update_post_avg_rating(payload)
          Try do
            post_repo.update_avg_rating(payload)
          end.to_result
        end
      end
    end
  end
end
