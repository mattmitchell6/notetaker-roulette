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
  :subtitle => "matt",
  :image => "mattmitchell.jpg"
}, {
  :name => "Govind Dandekar",
  :subtitle => "govind",
  :image => "govind.jpg"
}, {
  :name => "Dom Grillo",
  :subtitle => "dom",
  :image => "dominic.jpg"
}, {
  :name => "Adam Stevenson",
  :subtitle => "adam",
  :image => "adam.jpg"
}, {
  :name => "Russ Hudson",
  :subtitle => "russ",
  :image => "russ.jpg"
}, {
  :name => "Morgan Christian",
  :subtitle => "morgan",
  :image => "morgan.jpg"
}, {
  :name => "Nate Linsky",
  :subtitle => "nate",
  :image => "natelinsky.jpg"
}, {
  :name => "Wildcard",
  :subtitle => "wildcard",
  :image => "marko.jpg",
  :imageColor => "markoColor.jpg"
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
    candidates = params[:candidates]

    if (candidates)
      candidates = candidates.split(',')
      ap candidates
      total = []
      candidates.each do |candidate|
        index = SAS.find_index { |sa| sa[:subtitle].eql? candidate }
        if(index != nil)
          total.push(SAS[index])
        end
      end
      @winner = total.sample

      # handle 0 results case
      if(total.length == 0)
        @winner = SAS.sample
      end
    else
      @winner = SAS.sample
    end

    erb :notetaker
  end

end
