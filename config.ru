# config.ru
require "./server"
require 'sass/plugin/rack'
require_relative './config/environment'


Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run App
