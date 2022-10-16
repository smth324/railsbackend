class AddUnitToType < ActiveRecord::Migration[7.0]
  def change
    add_column :types, :unit, :string
  end
end
