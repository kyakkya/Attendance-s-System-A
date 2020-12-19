class AddMonthSuperiorToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :month_superior, :string
  end
end
