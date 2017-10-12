class UsersController < ApplicationController

    def login
			user = User.find_by(email: params[:email])
			if user && user.authenticate(params[:password])
			  render json: {id: user.id}, status: :ok
			else
			  render json: {error: 'Wrong email or password'}, status: :unauthorized
		  end
    end
end
