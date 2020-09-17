require 'rake'
require 'pg'
require 'pry'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end

namespace :db do
  task :drop do
    conn_default = PG.connect(dbname: 'postgres', host: 'localhost', user: 'postgres', password: 'postgres')
    conn_default.exec('DROP DATABASE interview_app')
  end

  task :prepare do
    conn_default = PG.connect(dbname: 'postgres', host: 'localhost', user: 'postgres', password: 'postgres')
    conn_default.exec('CREATE DATABASE interview_app')
    conn_interview_app = PG.connect(dbname: 'interview_app', host: 'localhost', user: 'postgres', password: 'postgres')
    conn_interview_app.exec('create table public.users (id SERIAL PRIMARY KEY, login text NOT NULL, ip text, created_at timestamp DEFAULT current_timestamp, updated_at timestamp DEFAULT current_timestamp)')
    conn_interview_app.exec('create table public.posts (id SERIAL PRIMARY KEY, login text NOT NULL, user_id integer, title text NOT NULL , body text  NOT NULL, votes integer NOT NULL DEFAULT 0, total_rating integer NOT NULL DEFAULT 0, avg_rating integer DEFAULT 0, created_at timestamp DEFAULT current_timestamp, updated_at timestamp DEFAULT current_timestamp)')
  end
end
