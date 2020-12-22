class AddMonthNextdayToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :month_nextday, :string
  end
end
