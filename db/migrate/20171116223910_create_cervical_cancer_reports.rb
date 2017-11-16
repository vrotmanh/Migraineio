class CreateCervicalCancerReports < ActiveRecord::Migration[5.1]
  def change
    create_table :cervical_cancer_reports do |t|
      t.float :age
      t.float :sexual_partners
      t.float :first_sex_age
      t.float :num_pregnancy
      t.float :smoker
      t.float :smoke_years
      t.float :packs_a_year
      t.float :hormonal_contraceptive
      t.float :hormonal_contraceptive_years
      t.float :iud
      t.float :iud_years
      t.float :stds
      t.float :num_stds
      t.float :std_condylomatosis
      t.float :std_cervical_condylomatosis
      t.float :std_vaginal_condylomatosis
      t.float :std_vulvo_perineal_condylomatosis
      t.float :std_syphilis
      t.float :std_pelvic_inflamatory_disease
      t.float :std_genital_herpes
      t.float :std_molluscum_contagiosum
      t.float :std_aids
      t.float :std_hiv
      t.float :std_hepatitis_b
      t.float :std_hpv
      t.float :std_num_diagnosis
      t.float :std_time_first_diagnosis
      t.float :std_time_last_diagnosis
      t.float :dx_cancer
      t.float :dx_cin
      t.float :dx_hpv
      t.float :dx
      t.boolean :hinselmann_prediction
      t.boolean :schiller_prediction
      t.boolean :cytology_prediction
      t.boolean :biopsy_prediction
      t.boolean :hinselmann_label
      t.boolean :schiller_label
      t.boolean :cytology_label
      t.boolean :biopsy_label
      t.boolean :train_data
      t.timestamps
    end
  end
end
