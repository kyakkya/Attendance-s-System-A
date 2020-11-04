class AddSuperiorToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :superior, :string
  end
end
