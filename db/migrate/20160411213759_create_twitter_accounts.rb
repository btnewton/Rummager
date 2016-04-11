class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.string :name
      t.string :screenname
      t.string :profile_picture_url

      t.timestamps null: false
    end
  end
end
