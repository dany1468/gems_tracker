class CreateUnreadGem < ActiveRecord::Migration[5.0]
  def change
    create_table :unread_gems do |t|
      t.string :name, null: false
      t.string :description
      t.string :version, null: false
      t.string :url, null: false
    end
  end
end
