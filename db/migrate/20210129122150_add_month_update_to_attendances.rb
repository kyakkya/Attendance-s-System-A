class AddMonthUpdateToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :month_update, :date
  end
end
