class AddPlaceNameToPositions < ActiveRecord::Migration[5.1]
  def change
    add_column :positions, :place_name, :string
  end
end
