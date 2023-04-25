class WeatherFacade
	def get_forecast(coordinates)
		forecast = service.get_forecast(coordinates)
		Forecast.new(forecast)
	end

	def get_forecast_for(time_epoch, coordinates)
		forecast = service.get_forecast(coordinates)
		array = forecast[:forecast][:forecastday].map {|day| day[:hour]}.flatten
		weather = array.find {|hour| hour[:time_epoch] == time_epoch}
		DestinationWeather.new(weather)
	end

	def service
		@service ||= WeatherService.new
	end
end