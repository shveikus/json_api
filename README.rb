Requirements:
  1. update psql database url connection at config/environment.rb:22
  2. preapre DB executing ```bundle exec rake db:prepare```
  3. run server ```bundle exec rackup```

Seeds: db/seeds.rb

Endpoints:

1) create post
curl -w %{time_total} -i -X POST  -d '{ "body": "some post body", "title": "Lorem ipsum", "login": "f24ff4"}' -H 'Content-Type: application/json' http://localhost:9292/api/v1/post

2) update rating
curl -w %{time_total} -i -X POST -d '{ "user_rate": 5 , "post_id": 1}' -H 'Content-Type: application/json' http://localhost:9292/api/v1/post/vote

3) request top N posts by averrage rating
curl -w %{time_total} -i -H 'Content-Type: application/json' http://localhost:9292/api/v1/post/top-rating\?top\=4

4) request IP list with more than one athor
curl -w %{time_total} -i   http://localhost:9292/api/v1/post/ip-list
