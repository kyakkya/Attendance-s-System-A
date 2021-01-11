class AddTotalMonthToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :total_month, :string
  end
end
