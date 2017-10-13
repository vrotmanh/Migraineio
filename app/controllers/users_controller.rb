class UsersController < ApplicationController

  def login
	  unless params[:email]
			render json: {error: "Email is missing"}, status: :unprocessable_entity
			return
		end
	  unless params[:password]
			render json: {error: "Password is missing"}, status: :unprocessable_entity
			return
		end
	  unless params[:kind]
			render json: {error: "Kind is missing"}, status: :unprocessable_entity
			return
		end
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
      if user.kind != params[:kind]
        render json: {error: 'Invalid login'}, status: :unauthorized
      else
        render json: {id: user.id, name: user.name}, status: :ok
      end
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
			unless params[:name]
				render json: {error: "Name is missing"}, status: :unprocessable_entity
				return
			end
			unless params[:email]
				render json: {error: "Email is missing"}, status: :unprocessable_entity
				return
			end
			unless params[:password]
				render json: {error: "Password is missing"}, status: :unprocessable_entity
				return
			end
			unless params[:kind]
				render json: {error: "Kind is missing"}, status: :unprocessable_entity
				return
			end
		end
  end
end
