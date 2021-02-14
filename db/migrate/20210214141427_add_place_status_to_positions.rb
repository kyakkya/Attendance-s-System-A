class AddPlaceStatusToPositions < ActiveRecord::Migration[5.1]
  def change
    add_column :positions, :place_status, :string
  end
end
