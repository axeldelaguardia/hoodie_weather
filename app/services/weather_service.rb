class WeatherService
	def connection
		Faraday.new(url: "https://api.weatherapi.com") do |con|
			con.params[:key] = ENV['WEATHER_API_KEY']
		end
	end

	def get_forecast(long_lat)
		response = connection.get("/v1/forecast.json") do |req|
			req.params[:q] = long_lat
			req.params[:days] = 5
			req.params[:aqi] = "no"
			req.params[:alerts] = "no"
		end
		JSON.parse(response.body, symbolize_names: true)
	end
end