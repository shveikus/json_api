# frozen_string_literal: true

class App < Hanami::API
  include Dry::Monads::Result::Mixin
  use Hanami::Middleware::BodyParser, :json

  post '/api/v1/post' do
    result = InterviewApp::Operations::Post::Create.new.call params

    case result
    when Success
      Oj.dump(result.success.to_h)
    when Failure
      [422, Oj.dump(result.failure).to_s]
    end
  end

  post '/api/v1/post/vote' do
    result = InterviewApp::Operations::Post::Vote.new.call params

    case result
    when Success
      Oj.dump(result.success.to_h)
    when Failure
      if result.failure.is_a?(NoMethodError)
        [422, 'post with query params not found']
      else
        [422, Oj.dump(result.failure).to_s]
      end
    end
  end

  get '/api/v1/post/top-rating' do
    params[:top] = params[:top]&.to_i
    result = InterviewApp::Operations::Post::VoteTopRating.new.call params

    case result
    when Success
      Oj.dump(result.success)
    when Failure
      [422, Oj.dump(result.failure).to_s]
    end
  end

  get '/api/v1/post/ip-list' do
    result = InterviewApp::Operations::Post::IpList.new.call

    case result
    when Success
      Oj.dump(result.success)
    when Failure
      [422, Oj.dump(result.failure).to_s]
    end
  end
end
