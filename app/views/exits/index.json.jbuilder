json.array!(@exits) do |exit|
  json.extract! exit, :id, :location_id, :destination_location_id
  json.url exit_url(exit, format: :json)
end
