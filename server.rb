require 'sinatra'
require "sinatra/activerecord"
require 'dotenv/load'
require 'awesome_print'
require 'json'
require './models/team'
require './models/member'

use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :secret => 'SecureRandom.hex(64)'

class App < Sinatra::Base

  teamMembers = JSON.parse(File.read('team_members.json'))

  # Home route
  get '/' do
    @teams = Team.all
    @baseUrl = request.base_url

    erb :index
  end

  # Create new team
  post '/create-team' do
    teamName = params[:name]
    url = teamName.gsub(/[^a-zA-Z0-9\-]/,"").downcase
    Team.create(name: teamName, url: url)
    redirect '/'
  end

  # Create new member
  post '/:teamId/create-member' do
    memberName = params[:name]
    teamId = params[:teamId]
    
    url = teamName.gsub(/[^a-zA-Z0-9\-]/,"").downcase
    Team.create(name: teamName, url: url)

    redirect '/'
  end  

  # Admin route
  # get '/admin' do
  #   erb :admin
  # end

  # Delete team
  get '/delete/:id' do
    teamId = params[:id]
    
    Team.delete(teamId)

    redirect '/'
  end

  # Manage members route
  get '/:team/manage-members' do
    @team = Team.find_by(url: params[:team])

    # redirect to home page if team doesn't exist
    if(!@team)
      redirect '/'
    end

    @members = Member.find_by(team_id: @team[:id])

    erb :managemembers
  end

  # Base team route
  get '/:team' do
    team = Team.find_by(url: params[:team])
    ap team

    # redirect to home page if team doesn't exist
    if(!team)
      redirect '/'
    end

    members = Member.find_by(team_id: team[:id])

    if(members)
      ap members
      erb :team_base
    else
      ap members
      redirect '/' + team[:url] + '/manage-members'
    end
    
    
  end


  # Calculate notetaker
  get '/notetaker' do
    candidates = params[:candidates]

    if(candidates)
      candidates = candidates.split(',')
      total = []

      candidates.each do |candidate|
        index = teamMembers.find_index { |sa| sa["subtitle"].eql? candidate }
        if(index != nil)
          total.push(teamMembers[index])
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
