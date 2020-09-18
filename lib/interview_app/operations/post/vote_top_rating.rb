module InterviewApp
  module Operations
    module Post
      class VoteTopRating < Operation
        include ImportRepos[
          post_repo: 'post_repo',
        ]

        VALIDATOR = Dry::Validation.JSON do
          required(:top).filled(:int?, gt?: 0)
        end

        def call(top)
          top = yield VALIDATOR.call(top).to_either
          posts = yield get_top_rating(top)

          Success(posts)
        end

        private

        def get_top_rating(top)
          Try(Hanami::Model::UniqueConstraintViolationError) do
            relation = post_repo.find_by_top_rating(top)
            relation.map { |i| { title: i[:title], body: i[:body] } }
          end.to_result
        end
      end
    end
  end
end
