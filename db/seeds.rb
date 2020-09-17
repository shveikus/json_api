require 'httparty'
require 'oj'
require 'faker'
require 'pry'

headers = {
  'Content-type' => 'application/json'
}

threads = []
start = Time.now
20.times do
  threads << Thread.new do
    100.times do |_i|
      @result = HTTParty.post('http://localhost:9292/api/v1/post',
                              body: {
                                "body": 'fdwfwf',
                                "title": 'fwk',
                                "login": rand(1...50).to_s,
                                "ip": "192.168.112.#{rand(50)}"
                              }.to_json,
                              headers: headers)
      puts 'Error' unless @result.code == 200
    end
  end
end

threads.each(&:join)

threads_rates = []
start = Time.now
20.times do
  threads_rates << Thread.new do
    1000.times do |_i|
      @result = HTTParty.post('http://localhost:9292/api/v1/post/vote',
                              body: {
                                "user_rate": rand(1...5),
                                "post_id": rand(1...2000)
                              }.to_json,
                              headers: headers)
      puts 'Error' unless @result.code == 200
    end
  end
end

threads_rates.each(&:join)
a =  Time.now - start
puts "#{a / 2000} per query"
