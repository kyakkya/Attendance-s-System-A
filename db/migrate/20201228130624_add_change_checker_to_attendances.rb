class AddChangeCheckerToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :change_checker, :boolean
  end
end
