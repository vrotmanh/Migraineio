class AddUserToCervicalCancerReports < ActiveRecord::Migration[5.1]
  def change
    add_column :cervical_cancer_reports, :user_id, :integer
  end
end
