class Api::V0::SalariesController < ApplicationController
	def index
		if params[:destination]
			salaries = TeleportFacade.new.get_salaries(params[:destination])
			render json: SalariesSerializer.new(salaries)
		end
	end
end