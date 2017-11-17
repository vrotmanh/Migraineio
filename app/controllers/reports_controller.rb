class ReportsController < ApplicationController

  def train_data_migraine
    reports = MigraineReport.where(train_data: true)
    res = to_csv(reports)
		render json: res, status: :ok
  end

  def train_data_cervical_cancer
    reports = CervicalCancerReport.where(train_data: true)
    res = to_csv(reports)
		render json: res, status: :ok
  end

  def create_cervical_cancer
	  unless params[:user_id]
			render json: {error: "User Id is missing"}, status: :unprocessable_entity
			return
		end
    algorithm = Algorithm.where(condition: 'cervical_cancer').order("accuracy DESC").first
      smoker = params[:smoker] ? 1.0:0.0
      iud = params[:iud] ? 1.0:0.0
      hormonal_contraceptive = params[:hormonal_contraceptive] ? 1.0:0.0
      stds = params[:stds] ? 1.0:0.0
      std_condylomatosis = params[:std_condylomatosis] ? 1.0:0.0
      std_cervical_condylomatosis = params[:std_cervical_condylomatosis] ? 1.0:0.0
      std_vaginal_condylomatosis = params[:std_vaginal_condylomatosis] ? 1.0:0.0
      std_vulvo_perineal_condylomatosis = params[:std_vulvo_perineal_condylomatosis] ? 1.0:0.0
      std_syphilis = params[:std_syphilis] ? 1.0:0.0
      std_pelvic_inflamatory_disease = params[:std_pelvic_inflamatory_disease] ? 1.0:0.0
      std_genital_herpes = params[:std_genital_herpes] ? 1.0:0.0
      std_molluscum_contagiosum = params[:std_molluscum_contagiosum] ? 1.0:0.0
      std_aids = params[:std_aids] ? 1.0:0.0
      std_hiv = params[:std_hiv] ? 1.0:0.0
      std_hepatitis_b = params[:std_hepatitis_b] ? 1.0:0.0
      std_hpv = params[:std_hpv] ? 1.0:0.0
      dx_cancer = params[:dx_cancer] ? 1.0:0.0
      dx_cin = params[:dx_cin] ? 1.0:0.0
      dx_hpv = params[:dx_hpv] ? 1.0:0.0
      dx = params[:dx] ? 1.0:0.0
    report = CervicalCancerReport.create(user: User.find(params[:user_id].to_i), algorithm: algorithm, age: params[:age],
                                         sexual_partners: params[:sexual_partners], first_sex_age: params[:first_sex_age],
                                        num_pregnancy: params[:num_pregnancy], smoker: smoker,
                                        smoke_years: params[:smoke_years], packs_a_year: params[:packs_a_year],
                                        hormonal_contraceptive: hormonal_contraceptive,
                                        hormonal_contraceptive_years: params[:hormonal_contraceptive_years],
                                        iud: iud, iud_years: params[:iud_years], stds: stds,
                                        num_stds: params[:num_stds], std_condylomatosis: std_condylomatosis,
                                        std_cervical_condylomatosis: std_cervical_condylomatosis,
                                        std_vaginal_condylomatosis: std_vaginal_condylomatosis,
                                        std_vulvo_perineal_condylomatosis: std_vulvo_perineal_condylomatosis,
                                        std_syphilis: std_syphilis, std_pelvic_inflamatory_disease: std_pelvic_inflamatory_disease,
                                        std_genital_herpes: std_genital_herpes, std_molluscum_contagiosum: std_molluscum_contagiosum,
                                        std_aids: std_aids, std_hiv: std_hiv, std_hepatitis_b: std_hepatitis_b,
                                        std_hpv: std_hpv, std_num_diagnosis: params[:std_num_diagnosis],
                                        std_time_first_diagnosis: params[:std_time_first_diagnosis], std_time_last_diagnosis: params[:std_time_last_diagnosis],
                                        dx_cancer: dx_cancer, dx_cin: dx_cin, dx_hpv: dx_hpv, dx: dx)
		if report.errors.empty?
      CSV.open("dataset.csv", "wb") do |csv|
        CervicalCancerReport.where(train_data: true).each do |report|
          csv << [report.age, report.sexual_partners, report.first_sex_age, report.num_pregnancy, report.smoker, report.smoke_years, report.packs_a_year, report.hormonal_contraceptive, report.hormonal_contraceptive_years, report.iud, report.iud_years, report.stds, report.num_stds, report.std_condylomatosis, report.std_cervical_condylomatosis, report.std_vaginal_condylomatosis, report.std_vulvo_perineal_condylomatosis, report.std_syphilis, report.std_pelvic_inflamatory_disease, report.std_genital_herpes, report.std_molluscum_contagiosum, report.std_aids, report.std_hiv, report.std_hepatitis_b, report.std_hpv, report.std_num_diagnosis, report.std_time_first_diagnosis, report.std_time_last_diagnosis, report.dx_cancer, report.dx_cin, report.dx_hpv, report.dx, report.hinselmann_label, report.schiller_label, report.cytology_label, report.biopsy_label ]
        end
      end
      report_python = "report = [#{params[:age]},#{params[:sexual_partners]},#{params[:first_sex_age]},#{params[:num_pregnancy]},#{smoker},#{params[:smoke_years]},#{params[:packs_a_year]},#{hormonal_contraceptive},#{params[:hormonal_contraceptive_years]},#{iud},#{params[:iud_years]},#{stds},#{params[:num_stds]},#{std_condylomatosis},#{std_cervical_condylomatosis},#{std_vaginal_condylomatosis},#{std_vulvo_perineal_condylomatosis},#{std_syphilis},#{std_pelvic_inflamatory_disease},#{std_genital_herpes},#{std_molluscum_contagiosum},#{std_aids},#{std_hiv},#{std_hepatitis_b},#{std_hpv},#{params[:std_num_diagnosis]},#{params[:std_time_first_diagnosis]},#{params[:std_time_last_diagnosis]},#{dx_cancer},#{dx_cin},#{dx_hpv},#{dx}]"
      header = "import numpy\ntrain_data=numpy.loadtxt(open(\"dataset.csv\",\"rb\"), delimiter=\",\").tolist()\n" + report_python
      run_python = header + '\n' + algorithm.code + '\nres=algo(train_data,report)\nprint(res)'
      c = "`python -c '#{run_python}'`"
      r = eval(c).delete!("\n").delete!("[").delete!("]").delete!(" ").split(',')
      r = r.map(&:to_f)
      puts '----------------------------------------RESULT---------------------------------'
      puts r
      puts '----------------------------------------RESULT---------------------------------'
      if r[0] != 0.0
        report.hinselmann_prediction = true
      else
        report.hinselmann_prediction = false
      end
      if r[1] != 0.0
        report.schiller_prediction = true
      else
        report.schiller_prediction = false
      end
      if r[2] != 0.0
        report.cytology_prediction = true
      else
        report.cytology_prediction = false
      end
      if r[3] != 0.0
        report.biopsy_prediction = true
      else
        report.biopsy_prediction = false
      end
      report.save
      render json: {hinselmann: report.hinselmann_prediction, schiller: report.schiller_prediction, cytology: report.cytology_prediction, biopsy: report.cytology_prediction }, status: :created
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
