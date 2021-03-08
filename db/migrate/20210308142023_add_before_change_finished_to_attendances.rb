class AddBeforeChangeFinishedToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :before_change_finished, :time
  end
end
