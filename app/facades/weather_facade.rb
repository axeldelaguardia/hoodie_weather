class WeatherFacade
	def get_forecast(coordinates)
		forecast = service.get_forecast(coordinates)
		Forecast.new(forecast)
	end

	def service
		@service ||= WeatherService.new
	end
end