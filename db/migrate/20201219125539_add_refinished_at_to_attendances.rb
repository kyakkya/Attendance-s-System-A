class AddRefinishedAtToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :refinished_at, :time
  end
end