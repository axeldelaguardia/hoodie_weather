class Api::V0::SessionsController < ApplicationController
	rescue_from ValidationException, with: :error_serializer

	def login
		user = User.find_by(email: session_params[:email])
		if user && user.authenticate(session_params[:password])
			render json: UserSerializer.new(user)
		else
			render json: ErrorSerializer.custom("Email or Password are incorrect"), status: 400
		end
	end

	private
	def session_params
		params.require(:session).permit(:email, :password)
	end
end