require 'sinatra'
require "sinatra/activerecord"
require 'dotenv/load'
require 'awesome_print'
require 'json'
require 'carrierwave'
require 'carrierwave/orm/activerecord'

require './helpers/image_uploader'
require './models/team'
require './models/member'

use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :secret => 'SecureRandom.hex(64)'

class App < Sinatra::Base

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
  post '/:team/create-member' do 
    teamName = params[:team]

    member = Member.new

    member.full_name = params[:name]
    member.team_id = params[:teamId]
    member.first_name = params[:name].gsub(/[^a-zA-Z0-9\-]/,"").downcase    
    member.image = params[:file]

    # save
    member.save!    

    # Member.create(team_id: teamId, full_name: memberName, first_name: shortname)

    redirect '/' + teamName + '/manage-members'
  end  

  # Delete team
  get '/delete-team/:id' do
    teamId = params[:id]
    
    Team.delete(teamId)

    redirect '/'
  end

  # Delete member
  get '/:team/delete-member/:id' do
    memberId = params[:id]
    @teamName = params[:team]
    
    Member.delete(memberId)

    redirect '/' + @teamName + '/manage-members'
  end  

  # Manage members route
  get '/:team/manage-members' do
    @teamName = params[:team]
    @team = Team.find_by(url: @teamName)

    # redirect to home page if team doesn't exist
    if(!@team)
      redirect '/'
    end

    @members = Member.where(team_id: @team[:id])

    erb :managemembers
  end

  # Base team route
  get '/:team' do
    @teamName = params[:team]
    team = Team.find_by(url: @teamName)

    # redirect to home page if team doesn't exist
    if(!team)
      redirect '/'
    end

    members = Member.where(team_id: team[:id])

    if(!members.empty?)
      erb :team_base
    else
      redirect '/' + team[:url] + '/manage-members'
    end
  end


  # Calculate notetaker
  get '/:team/notetaker' do
    @teamName = params[:team]
    candidates = params[:candidates]
    team = Team.find_by(url: @teamName)

    # redirect to home page if team doesn't exist
    if(!team)
      redirect '/'
    end

    members = Member.where(team_id: team[:id])

    if(members.empty?)
      redirect '/' + team[:url] + '/manage-members'
    end

    if(candidates)
      ap candidates
      candidates = candidates.split(',')
      total = []

      candidates.each do |candidate|
        index = members.find_index { |sa| sa["first_name"].eql? candidate }
        if(index != nil)
          total.push(members[index])
        end
      end

      @winner = total.sample

      # handle 0 results case
      if(total.length == 0)
        @winner = members.sample
      end
    else
      @winner = members.sample
      ap @winner
    end

    erb :notetaker
  end

end
