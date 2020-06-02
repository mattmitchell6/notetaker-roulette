require 'sinatra'
require 'dotenv/load'
require 'awesome_print'
require 'json'
use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :secret => 'SecureRandom.hex(64)'

class App < Sinatra::Base

  teamMembers = JSON.parse(File.read('team_members.json'))

  # Home route
  get '/' do
    erb :index
  end

  # Calculate notetaker
  get '/notetaker' do
    candidates = params[:candidates]

    if(candidates)
      candidates = candidates.split(',')
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
        @winner = teamMembers.sample
      end
    else
      @winner = teamMembers.sample
      ap @winner
    end

    erb :notetaker
  end

end
