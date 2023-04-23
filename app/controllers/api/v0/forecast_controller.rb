class Api::V0::ForecastController < ApplicationController
	def index
		location = MapQuestFacade.new(params).long_lat
		forecast = WeatherFacade.new.get_forecast(location.lat_lng)
		render json: ForecastSerializer.new(forecast)
	end
end