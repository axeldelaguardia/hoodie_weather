class Api::V0::SalariesController < ApplicationController
	before_action :check_params
	rescue_from ValidationException, with: :error_serializer

	def index
		if params[:destination]
			salaries = TeleportFacade.new.get_salaries(params[:destination])
			render json: SalariesSerializer.new(salaries)
		end
	end

	private
	def check_params
		if params[:destination].nil? || params[:destination].empty?
			raise ValidationException.new "params must be included"
		end
	end

	def error_serializer(message)
		render json: ErrorSerializer.custom(message), status: 400
	end
end