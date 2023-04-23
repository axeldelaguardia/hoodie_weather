class Api::V0::UsersController < ApplicationController
	before_action :confirm_password, only: :create
	rescue_from ValidationException, with: :error_serializer
	wrap_parameters :user, include: [:email, :password, :password_confirmation]

	def create
		user = User.create(user_params)
		if user.save
			render json: UserSerializer.new(user)
		else
			render json: ErrorSerializer.model_error(user.errors), status: 400
		end
	end

	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

	def confirm_password
		if user_params[:password] != user_params[:password_confirmation]
			raise ValidationException.new "passwords don't match"
		end
	end

	def error_serializer(message)
		render json: ErrorSerializer.custom(message), status: 400
	end
end