# config.ru
require "./server"

if ENV['RACK_ENV'] == "development"
  set :database, "sqlite3:sa-round-robin.sqlite3"
end

run App
