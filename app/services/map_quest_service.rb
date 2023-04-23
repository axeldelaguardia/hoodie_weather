class MapQuestService
	def connection
		Faraday.new(url: "https://www.mapquestapi.com") do |con|
			con.params[:key] = ENV['MAP_QUEST_KEY']
		end
	end

	def get_long_lat(city_state)
		response = connection.get("/geocoding/v1/address") do |req|
			req.params[:location] = city_state
		end
		JSON.parse(response.body, symbolize_names: true)
	end
end