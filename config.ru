# config.ru
require "./server"
require 'sass/plugin/rack'

# if ENV['RACK_ENV'] == "development"
#   set :database, "sqlite3:sa-round-robin.sqlite3"
# end
#
# if ENV['RACK_ENV'] == "production"
#   ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
# end

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run App
