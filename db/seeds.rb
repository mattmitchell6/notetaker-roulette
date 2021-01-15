# db/seeds.rb
# require '../../models/member.rb'
# require '../../models/team.rb'

team = {name: "test team", url: "testteam3"}

members = [
  {full_name: 'Jane Doe', first_name: 'jane'},
  {full_name: 'Juan Doe', first_name: 'juan'}
]

Team.create(team)

foundTeam = Team.find_by(url: "testteam3")
ap foundTeam

# foundMembers = Member.find_by(team_id: foundTeam[:id])
# ap foundMembers

members.each do |m|
  Member.create(
    team_id: foundTeam[:id], 
    full_name: m[:full_name],
    first_name: m[:first_name]
  )
end