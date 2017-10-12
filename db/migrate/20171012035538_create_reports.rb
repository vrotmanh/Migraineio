class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.integer :stress
      t.integer :anxiety
      t.float :sleep_time
      t.boolean :chocolate
      t.boolean :cheese
      t.boolean :sinus
      t.boolean :caffeine
      t.boolean :skipped_meal
      t.boolean :prediction

      t.timestamps
    end
  end
end
