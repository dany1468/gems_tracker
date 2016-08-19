class CreateIgnoringGem < ActiveRecord::Migration[5.0]
  def change
    create_table :ignoring_gems do |t|
      t.string :name, null: false
      t.string :registered_version, null: false
    end
  end
end
