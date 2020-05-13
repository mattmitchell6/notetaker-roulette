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
  :name => "Chintan Sanghvi",
  :subtitle => "chintan",
  :image => "csanghvi.jpg"
}, {
  :name => "David Santoso",
  :subtitle => "david",
  :image => "davidsantoso.jpg"
}, {
  :name => "Karthik Nagarajan",
  :subtitle => "karthik",
  :image => "karthikn.jpg"
}, {
  :name => "Kirby Kohlmorgen",
  :subtitle => "kirby",
  :image => "kirby.jpg"
}, {
  :name => "Miles Matthias",
  :subtitle => "miles",
  :image => "miles.jpg"
}, {
  :name => "Jill Farnsworth",
  :subtitle => "jill",
  :image => "jill.jpg"
}]

class App < Sinatra::Base

  # Home route
  get '/' do
    erb :index
  end

  get '/notetaker' do
    candidates = params[:candidates]

    if(candidates)
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
