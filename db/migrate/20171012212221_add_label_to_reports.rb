class AddLabelToReports < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :label, :boolean
  end
end
