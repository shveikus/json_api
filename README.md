## Requirements:
  1. start Postresql server (```docker run -d --name psql -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres  -p 5432:5432 postgres```)
  2. update psql connection url at ```config/environment.rb:22```
  3. preapre DB executing ```bundle exec rake db:prepare```
  4. run server ```bundle exec rackup```

## Seeds:
  db/seeds.rb

## Endpoints:

1) create post
```curl -w %{time_total} -i -X POST  -d '{ "body": "some post body", "title": "some title", "login": "f24ff4"}' -H 'Content-Type: application/json' http://localhost:9292/api/v1/post```

2) update rating
```curl -w %{time_total} -i -X POST -d '{ "user_rate": 5 , "post_id": 1}' -H 'Content-Type: application/json' http://localhost:9292/api/v1/post/vote```

3) get top N posts by averrage rating
```curl -w %{time_total} -i -H 'Content-Type: application/json' http://localhost:9292/api/v1/post/top-rating\?top\=4```

4) get IP list with more than one author
```curl -w %{time_total} -i   http://localhost:9292/api/v1/post/ip-list```
