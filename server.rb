require 'sinatra'
require 'dotenv/load'
require 'awesome_print'
require 'sinatra/activerecord'

require './models/round-robin'

SAS = [{
  :name => "Matt Mitchell",
  :subtitle => "not a component lead",
  :image => "mattmitchell.jpg"
}, {
  :name => "Govind Dandekar",
  :subtitle => "component lead",
  :image => "govind.jpg"
}]

class App < Sinatra::Base

  # Home route, fetch current SA
  get '/' do
    currentSA = RoundRobin.find(1)
    @currentSA = SAS.find {|sa| sa[:name] == currentSA.startups_sa}
    erb :index
  end

  # round robin to the next SA
  get '/update-startups' do
    currentSA = RoundRobin.find(1)
    newCount = currentSA.startups_count + 1
    newSA = SAS[newCount % 2]

    RoundRobin.update(1, :startups_count => newCount, :startups_sa => newSA[:name])

    redirect '/'
  end

end
