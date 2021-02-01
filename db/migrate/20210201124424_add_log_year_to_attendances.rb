class AddLogYearToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :log_year, :date
  end
end
