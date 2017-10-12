class AddNameToAlgorithms < ActiveRecord::Migration[5.1]
  def change
    add_column :algorithms, :name, :string
  end
end
