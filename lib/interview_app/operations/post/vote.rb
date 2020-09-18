module InterviewApp
  module Operations
    module Post
      class Vote < Operation
        include ImportRepos[
          post_repo: 'post_repo'
        ]

        VALIDATOR = Dry::Validation.JSON do
          required(:user_rate).filled(:int?)
          required(:post_id).filled(:int?)
        end

        def call(payload)
          payload = yield VALIDATOR.call(payload).to_either
          post = yield calculate_and_update_post_avg_rating(payload)

          Success({ avg_rating: post.avg_rating })
        end

        private

        def persist_post(payload)
          Try do
            post_repo.find_post(payload[:post_id])
          end.to_result
        end

        def calculate_and_update_post_avg_rating(payload)
          Try do
            post_relation = post_repo.posts.where(id: payload[:post_id])
            post_relation.lock do
              post = post_relation.map_to(Post).one
              total_rating = post.total_rating + payload[:user_rate]
              votes = post.votes + 1
              avg_rating = total_rating / votes
              new_post = ::Post.new({ total_rating: total_rating, votes: votes, avg_rating: avg_rating })
              post_repo.update(post.id, new_post)
            end
          end.to_result
        end
      end
    end
  end
end
