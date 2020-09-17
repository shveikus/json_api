module InterviewApp
  module Operations
    module Post
      class IpList < Operation
        include ImportRepos[
          user_repo: 'user_repo',
        ]

        def call
          ip_list = yield get_ip_list

          Success(ip_list)
        end

        private

        def get_ip_list
          Try(Hanami::Model::UniqueConstraintViolationError) do
            user_repo.find_ip_list
          end.to_result
        end
      end
    end
  end
end
