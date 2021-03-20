class AddBeforeChangeStartedToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :before_change_started, :datetime
  end
end
