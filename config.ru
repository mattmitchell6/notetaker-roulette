# config.ru
require "./server"

if ENV['RACK_ENV'] == "development"
  set :database, "sqlite3:sa-round-robin.sqlite3"
end

if ENV['RACK_ENV'] == "production"
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
end

run App
