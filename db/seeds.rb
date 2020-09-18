require 'httparty'
require 'oj'
require 'faker'
require 'progress_bar'
require 'pry'

headers = {
  'Content-type' => 'application/json'
}

threads = []
logins = []
50.times do
  logins << Faker::Internet.user_name
end

bar_posts = ProgressBar.new 200_000

puts 'Start creating via http endpoint 200k posts'
20.times do
  threads << Thread.new do
    10_000.times do |_i|
      bar_posts.increment!
      @result = HTTParty.post('http://localhost:9292/api/v1/post',
                              body: {
                                "body": Faker::Lorem.sentence,
                                "title": Faker::Lorem.word,
                                "login": logins.sample,
                                "ip": "192.168.112.#{rand(50)}"
                              }.to_json,
                              headers: headers)
      puts 'Error: #{@result.body}' unless @result.code == 200
    end
  end
end

threads.each(&:join)

threads_rates = []
bar_votes = ProgressBar.new 20_000
puts 'Starting creating via http endpoint 2k votes'
20.times do
  threads_rates << Thread.new do
    1000.times do |_i|
      bar_votes.increment!
      @result = HTTParty.post('http://localhost:9292/api/v1/post/vote',
                              body: {
                                "user_rate": rand(1...5),
                                "post_id": rand(1...200_000)
                                # "user_rate": 1,
                                # "post_id": 1
                              }.to_json,
                              headers: headers)
      puts 'Error' unless @result.code == 200
    end
  end
end

threads_rates.each(&:join)
