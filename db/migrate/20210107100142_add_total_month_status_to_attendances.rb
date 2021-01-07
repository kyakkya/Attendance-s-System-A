class AddTotalMonthStatusToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :total_month_status, :string
  end
end
