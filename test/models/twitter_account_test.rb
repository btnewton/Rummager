require 'test_helper'

class TwitterAccountTest < ActiveSupport::TestCase
 
  test "Twitter account does not save with if value nil" do
  	twitter_account = TwitterAccount.new
  	assert_not twitter_account.save
  end

  test "New twitter account is invalid" do
  	twitter_account = TwitterAccount.new
  	assert twitter_account.invalid?
  end

  test "Recent twitter acount should not be reloaded" do
    twitter_account = twitter_accounts(:elonmusk)
  	assert_not twitter_account.requires_reload?
  end

  test "old twitter acount should be reloaded" do
    twitter_account = twitter_accounts(:elonmusk)
    twitter_account.updated_at = DateTime.new(1992, 12, 19)
    assert twitter_account.requires_reload?
  end

end
