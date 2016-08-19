class AddUniqIndexToTrackingGem < ActiveRecord::Migration[5.0]
  def change
    add_index :tracking_gems, :name, unique: true
  end
end
