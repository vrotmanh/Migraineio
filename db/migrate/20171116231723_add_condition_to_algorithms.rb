class AddConditionToAlgorithms < ActiveRecord::Migration[5.1]
  def change
    add_column :algorithms, :condition, :string
  end
end
