class Api::V0::SessionsController < ApplicationController
	before_action :check_params
	rescue_from ValidationException, with: :error_serializer

	def create
		require 'pry'; binding.pry
		User.create(session_params)
	end

	private
	def session_params
		params.require(:session).permit(:email, :password)
	end

	# def check_params
	# 	if params[:location].nil?
	# 		raise ValidationException.new "missing location params"
	# 	elsif !params[:location].match(/^([^,]*),\s*(\w*)\s*(\d*)?$/)
	# 		raise ValidationException.new "location must be a city,st"
	# 	end
	# end

	# def error_serializer(message)
	# 	render json: ErrorSerializer.custom(message), status: 400
	# end
end