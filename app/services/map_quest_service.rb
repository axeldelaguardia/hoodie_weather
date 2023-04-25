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

	def get_directions(to, from)
		response = connection.get("/directions/v2/route") do |req|
			req.params[:to] = to
			req.params[:from] = from
			req.params[:outFormat] = "json"
			req.params[:routeType] = "fastest"
			req.params[:ambiguities] = "ignore"
			req.params[:doReverseGeocode] = "false"
			req.params[:enhancedNarrative] = "false"
			req.params[:avoidTimedConditions] = "false"
		end
		JSON.parse(response.body, symbolize_names: true)
	end
end