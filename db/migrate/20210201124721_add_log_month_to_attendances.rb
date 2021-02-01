class AddLogMonthToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :log_month, :date
  end
end
