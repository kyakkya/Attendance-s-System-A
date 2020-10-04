class AddMonthCheckSuperiorToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :month_check_superior, :string
  end
end
