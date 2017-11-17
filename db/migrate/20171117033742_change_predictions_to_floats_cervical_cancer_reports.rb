class ChangePredictionsToFloatsCervicalCancerReports < ActiveRecord::Migration[5.1]
  def change
    change_column :cervical_cancer_reports, :hinselmann_label, :float, :using => 'case when hinselmann_label is null then null when hinselmann_label then 1.0 else 0.0 end'
    change_column :cervical_cancer_reports, :schiller_label, :float, :using => 'case when schiller_label is null then null when schiller_label then 1.0 else 0.0 end'
    change_column :cervical_cancer_reports, :cytology_label, :float, :using => 'case when cytology_label is null then null when cytology_label then 1.0 else 0.0 end'
    change_column :cervical_cancer_reports, :biopsy_label, :float, :using => 'case when biopsy_label is null then null when biopsy_label then 1.0 else 0.0 end'
  end
end
