class WeatherFacade
	def initialize(params)
		@params = params
	end

	def get_forecast
		forecast = service.get_forecast(@params[:coordinates])
		Forecast.new(forecast)
	end

	def service
		@service ||= WeatherService.new
	end
end