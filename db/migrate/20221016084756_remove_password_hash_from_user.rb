class RemovePasswordHashFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :passwordHash
  end
end
