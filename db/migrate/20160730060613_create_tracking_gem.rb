class CreateTrackingGem < ActiveRecord::Migration[5.0]
  def change
    create_table :tracking_gems do |t|
      t.string :name, null: false
      t.string :latest_version, null: false
      t.string :source_url
    end
  end
end
