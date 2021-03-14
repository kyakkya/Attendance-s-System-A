class ChangeDatatypeRestartedAtOfAttendances < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :restarted_at, :datetime
  end

end