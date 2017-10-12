class AddAccuracyToAlgorithms < ActiveRecord::Migration[5.1]
  def change
    add_column :algorithms, :accuracy, :float, default: 0
  end
end
