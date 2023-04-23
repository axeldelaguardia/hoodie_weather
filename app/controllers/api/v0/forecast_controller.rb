class Api::V0::ForecastController < ApplicationController
	before_action :check_params
	rescue_from ValidationException, with: :error_serializer

	def index
			location = MapQuestFacade.new(params).long_lat
			forecast = WeatherFacade.new.get_forecast(location.lat_lng)
			render json: ForecastSerializer.new(forecast)
	end

	private
	def check_params
		if params[:location].nil?
			raise ValidationException.new "missing location params"
		elsif !params[:location].match(/^([^,]*),\s*(\w*)\s*(\d*)?$/)
			raise ValidationException.new "location must be a city,st"
		end
	end

	def error_serializer(message)
		render json: ErrorSerializer.custom(message), status: 400
	end
end