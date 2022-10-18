class AddEmployerToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :store, foreign_key: true
  end
end
