require 'test_helper'

class TwitterCacheManagerTest < ActiveSupport::TestCase

	test "New twitter account should be reloaded" do
  	cache_manager = TwitterCacheManager.new TwitterAccount.new
  	assert cache_manager.requires_update?
  end

  test "Recent twitter account should not be reloaded" do
    twitter_account = twitter_accounts :elonmusk
    cache_manager = TwitterCacheManager.new(twitter_account)
  	assert_not cache_manager.requires_update?
  end

  test "old twitter account should be reloaded" do
    twitter_account = twitter_accounts :elonmusk
    twitter_account.updated_at = DateTime.new(1992, 12, 19)
    cache_manager = TwitterCacheManager.new(twitter_account)
  	assert cache_manager.requires_update?
  end

end