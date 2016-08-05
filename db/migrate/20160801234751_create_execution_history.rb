class CreateExecutionHistory < ActiveRecord::Migration[5.0]
  def change
    create_table :execution_histories do |t|
      t.bigserial :latest_tweet_id, null: false
      t.bigserial :start_tweet_id, null: false
    end
  end
end
