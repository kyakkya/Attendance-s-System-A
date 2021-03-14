class ChangeDatatypebeforeChangeFinishedOfAttendances < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :before_change_finished, :datetime
  end
end
