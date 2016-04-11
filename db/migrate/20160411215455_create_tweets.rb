class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.datetime :posted_at
      t.integer :retweets
      t.integer :likes
      t.references :twitter_account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
