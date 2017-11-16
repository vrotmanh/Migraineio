class ReportsController < ApplicationController

  def train_data
    reports = MigraineReport.where(train_data: true)
    res = to_csv(reports)
		render json: res, status: :ok
  end

  def create_cervical_cancer
	  unless params[:user_id]
			render json: {error: "User Id is missing"}, status: :unprocessable_entity
			return
		end
    algorithm = Algorithm.where(condition: 'cervical_cancer').order("accuracy DESC").first
    report = CervicalCancerReport.create(user: User.find(params[:user_id].to_i), algorithm: algorithm, age: params[:age])
		if report.errors.empty?
      c = "`python -c '#{algorithm.code}'`"
      r = eval(c)
      report.hinselmann_prediction = r
      report.save
			render json: {result: r}, status: :created
		else
			render json: {error: report.errors.full_messages}, status: :unprocessable_entity
		end
  end

  def create_migraine
	  unless params[:user_id]
			render json: {error: "User Id is missing"}, status: :unprocessable_entity
			return
		end
	  unless params[:stress]
			render json: {error: "Stress is missing"}, status: :unprocessable_entity
			return
		end
	  unless params[:anxiety]
			render json: {error: "Anxiety is missing"}, status: :unprocessable_entity
			return
		end
	  unless params[:sleep_time]
			render json: {error: "Sleep Time is missing"}, status: :unprocessable_entity
			return
		end
	  unless params[:chocolate]
			render json: {error: "Chocolate is missing"}, status: :unprocessable_entity
			return
		end
	  unless params[:cheese]
			render json: {error: "Cheese is missing"}, status: :unprocessable_entity
			return
		end
	  unless params[:sinus]
			render json: {error: "Sinus is missing"}, status: :unprocessable_entity
			return
		end
	  unless params[:caffeine]
			render json: {error: "Caffeine is missing"}, status: :unprocessable_entity
			return
		end
	  unless params[:skipped_meal]
			render json: {error: "Skipped Meal is missing"}, status: :unprocessable_entity
			return
		end
    algorithm = Algorithm.where(condition: 'migraine').order("accuracy DESC").first
    report = MigraineReport.create(user: User.find(params[:user_id].to_i), stress: params[:stress], anxiety: params[:anxiety],
                          sleep_time: params[:sleep_time], chocolate: params[:chocolate], cheese: params[:cheese], sinus: params[:sinus],
                         caffeine: params[:caffeine], skipped_meal: params[:skipped_meal], algorithm: algorithm)
		if report.errors.empty?
      c = "`python -c '#{algorithm.code}'`"
      r = eval(c)
      report.prediction = r
      report.save
			render json: {result: r}, status: :created
		else
			render json: {error: report.errors.full_messages}, status: :unprocessable_entity
		end
  end

  private
  	def to_csv(reports)
    	attributes = %w{user_id stress anxiety sleep_time chocolate cheese sinus caffeine skipped_meal label}

    	CSV.generate(headers: true) do |csv|
      	csv << attributes

      	reports.each do |report|
        	csv << attributes.map{ |attr| report.send(attr) }
      	end
    	end
  	end

end
