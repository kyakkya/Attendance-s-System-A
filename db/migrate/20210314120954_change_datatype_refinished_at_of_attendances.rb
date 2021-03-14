class ChangeDatatypeRefinishedAtOfAttendances < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :refinished_at, :datetime
  end
end
