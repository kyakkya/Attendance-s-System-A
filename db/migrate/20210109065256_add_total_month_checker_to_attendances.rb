class AddTotalMonthCheckerToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :total_month_checker, :boolean
  end
end
