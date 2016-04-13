class AddIndexToTwitterAccountsScreenname < ActiveRecord::Migration
  def change
  	add_index :twitter_accounts, :screenname, unique: true
  end
end
