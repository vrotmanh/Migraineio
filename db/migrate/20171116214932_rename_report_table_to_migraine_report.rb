class RenameReportTableToMigraineReport < ActiveRecord::Migration[5.1]
  def change
    rename_table :reports, :migraine_reports
  end
end
