class AddDesignatedWorkStartTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :designated_work_start_timet, :time
  end
end
