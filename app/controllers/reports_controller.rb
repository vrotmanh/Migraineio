class ReportsController < ApplicationController

  def train_data
    reports = Report.where(train_data: true)
    res = to_csv(reports)
		render json: res, status: :ok
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
