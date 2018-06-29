json.extract! team, :id, :hackathon_id, :name, :introduction, :created_at, :updated_at
json.url team_url(team, format: :json)
