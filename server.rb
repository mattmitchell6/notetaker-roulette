require 'sinatra'
require 'dotenv/load'
require 'awesome_print'
# require 'sinatra/activerecord'

# require './models/round-robin'
use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :secret => 'SecureRandom.hex(64)'

SAS = [{
  :name => "Matt Mitchell",
  :subtitle => "not a component lead",
  :image => "mattmitchell.jpg"
}, {
  :name => "Govind Dandekar",
  :subtitle => "component lead",
  :image => "govind.jpg"
}, {
  :name => "Dom Grillo",
  :subtitle => "component lead",
  :image => "dominic.jpg"
}, {
  :name => "Adam Stevenson",
  :subtitle => "component lead",
  :image => "adam.jpg"
}, {
  :name => "Russ Hudson",
  :subtitle => "component lead",
  :image => "russ.jpg"
}, {
  :name => "Morgan Christian",
  :subtitle => "component lead",
  :image => "morgan.jpg"
}, {
  :name => "Nate Linsky",
  :subtitle => "component lead",
  :image => "natelinsky.jpg"
}]

class App < Sinatra::Base

  # Home route, fetch current SA
  get '/' do
    # currentSA = RoundRobin.find(1)
    # @currentSA = SAS.find {|sa| sa[:name] == currentSA.startups_sa}
    erb :index
  end

  # round robin to the next SA
  get '/update-startups' do
    # currentSA = RoundRobin.find(1)
    # newCount = currentSA.startups_count + 1
    # newSA = SAS[newCount % 2]
    #
    # RoundRobin.update(1, :startups_count => newCount, :startups_sa => newSA[:name])

    redirect '/'
  end

  get '/notetaker' do
    @winner = SAS.sample
    ap @winner

    erb :notetaker
  end

end
