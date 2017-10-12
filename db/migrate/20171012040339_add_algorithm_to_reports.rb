class AddAlgorithmToReports < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :algorithm_id, :integer
  end
end
