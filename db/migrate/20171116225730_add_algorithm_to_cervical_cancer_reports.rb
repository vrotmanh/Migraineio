class AddAlgorithmToCervicalCancerReports < ActiveRecord::Migration[5.1]
  def change
    add_column :cervical_cancer_reports, :algorithm_id, :integer
  end
end
