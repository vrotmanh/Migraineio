class AlgorithmsController < ApplicationController

  def show
    if params[:user_id]
      @algorithms = Algorithm.where(user_id: params[:user_id])
    else
      @algorithms = Algorithm.all
    end
  end

  def create
    if params[:code] and params[:name] and params[:user_id]
      algorithm = Algorithm.create(name: params[:name], code: params[:code], user_id: params[:user_id])
      if algorithm.errors.empty?
        render json: {id: algorithm.id, name: algorithm.name}, status: :created
      else
        render json: {error: algorithm.errors.full_messages}, status: :unprocessable_entity
      end
    else
			unless params[:name]
				render json: {error: "Name is missing"}, status: :unprocessable_entity
				return
			end
			unless params[:code]
				render json: {error: "Code is missing"}, status: :unprocessable_entity
				return
			end
			unless params[:user_id]
				render json: {error: "User Id is missing"}, status: :unprocessable_entity
				return
			end
    end
  end
end
