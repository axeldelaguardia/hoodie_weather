class Api::V0::RoadTripController < ApplicationController
	def index
		user = User.find_by(api_key: params[:api_key])
		if user
			road_trip = MapQuestFacade.new.road_trip(params[:destination], params[:origin])
			render json: RoadTripSerializer.new(road_trip)
		end
	end
end