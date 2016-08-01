class CreateExecutionHistory < ActiveRecord::Migration[5.0]
  def change
    create_table :execution_histories do |t|
      t.integer :latest_tweet_id, null: false
      t.integer :start_tweet_id, null: false
    end
  end
end
