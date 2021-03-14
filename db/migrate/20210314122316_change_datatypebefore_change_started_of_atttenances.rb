class ChangeDatatypebeforeChangeStartedOfAtttenances < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :before_change_started, :datetime
  end
end
