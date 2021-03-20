class AddRestartedAtToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :restarted_at, :datetime
  end
end
