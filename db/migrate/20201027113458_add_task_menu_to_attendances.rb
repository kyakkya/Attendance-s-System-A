class AddTaskMenuToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :task_menu, :string
  end
end
