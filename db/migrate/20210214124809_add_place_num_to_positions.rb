class AddPlaceNumToPositions < ActiveRecord::Migration[5.1]
  def change
    add_column :positions, :place_num, :integer
  end
end
