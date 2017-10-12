class AlgorithmsController < ApplicationController

  def create
    if params[:code] and params[:name] and params[:user_id]
      algorithm = Algorithm.create(name: params[:name], code: params[:code], user_id: params[:user_id])
      if algorithm.errors.empty?
        render json: {id: algorithm.id, name: algorithm.name}, status: :created
      else
        render json: {error: algorithm.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error: algorithm.errors.full_messages}, status: :unprocessable_entity
    end
  end
end
