class UsersController < ApplicationController

  def login
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			render json: {id: user.id}, status: :ok
		else
			render json: {error: 'Wrong email or password'}, status: :unauthorized
		end
  end

	def create
		if params[:email] and params[:name] and params[:password] and params[:kind]
			user = User.create(email: params[:email], name: params[:name], password: params[:password], password_confirmation: params[:password], kind: params[:kind])
			if user.errors.empty?
				render json: {id: user.id}, status: :created
			else
				render json: {error: user.errors.full_messages}, status: :unprocessable_entity
			end
		else
			render json: {error: user.errors.full_messages}, status: :unprocessable_entity
		end
  end
end
