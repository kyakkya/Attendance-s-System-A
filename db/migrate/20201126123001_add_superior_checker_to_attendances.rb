class AddSuperiorCheckerToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :superior_checker, :boolean
  end
end
