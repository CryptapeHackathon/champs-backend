json.extract! team, :id, :hackathon_id, :name, :introduction, :created_at, :updated_at
json.address team.user.address
json.url hackathon_team_url(team.hackathon, team, format: :json)
