json.array!(@players) do |player|
  json.extract! player, :id, :name, :age, :location_id
  json.url player_url(player, format: :json)
end
