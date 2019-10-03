require 'sinatra'
require 'dotenv/load'
require 'awesome_print'
require 'sinatra/activerecord'

set :database, "sqlite3:sa-round-robin.sqlite3"

require './models'

class App < Sinatra::Base

  SAS = [{
    :name => "Matt Mitchell", :image => "mattmitchell.jpg"
  }, {
    :name => "Govind Dandekar", :image => "govind.jpg"
  }]

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
