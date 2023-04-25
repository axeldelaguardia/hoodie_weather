class TeleportService
	def connection
		Faraday.new(url: "https://api.teleport.org")
	end

	def get_city_info(city)
		response = connection.get("/api/urban_areas/slug:#{city}")
		JSON.parse(response.body, symbolize_names: true)
	end

	def get_salaries(city)
		response = connection.get("/api/urban_areas/slug:#{city}/salaries")
		JSON.parse(response.body, symbolize_names: true)
	end
end