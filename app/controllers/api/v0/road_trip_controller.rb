class Api::V0::RoadTripController < ApplicationController
	before_action :check_params
	rescue_from ValidationException, with: :error_serializer

	def index
		user = User.find_by(api_key: params[:api_key])
		if user
			road_trip = MapQuestFacade.new.road_trip(params[:destination], params[:origin])
			render json: RoadTripSerializer.new(road_trip)
		else
			raise ValidationException.new("api_key is not valid")
		end
	end

	private
	def check_params
		if params_check
			raise ValidationException.new "params must be included"
		end
	end

	def params_check
		params[:origin].nil? || params[:origin].empty? ||
		params[:destination].nil? || params[:destination].empty?
	end

	def error_serializer(message, status=400)
		if message.message == "api_key is not valid"
			status = 401
		end
		render json: ErrorSerializer.custom(message), status: status
	end
end