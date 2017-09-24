class AddUserToAlgorithms < ActiveRecord::Migration[5.1]
  def change
    add_column :algorithms, :user_id, :integer
  end
end
