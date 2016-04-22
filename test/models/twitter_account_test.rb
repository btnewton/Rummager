require 'test_helper'

class TwitterAccountTest < ActiveSupport::TestCase
 
  test "Twitter account does not save with if value nil" do
  	twitter_account = TwitterAccount.new
  	assert_not twitter_account.valid?
  end

  test "Sanitize handle returns same handle" do
  	handle = "testHandle"
    assert_equal handle, TwitterAccount.sanitize_handle(handle)
  end

  test "Sanitize handle returns same handle with numbers and underscore" do
    handle = "_t3st_Handle1"
    assert_equal handle, TwitterAccount.sanitize_handle(handle)
  end

  test "Sanitize handle removes symbols" do
    handle  = "test<>!\"Handle"
    assert_equal "testHandle", TwitterAccount.sanitize_handle(handle)
  end

  test "Sanitize handle does not break on empty input" do
    assert_equal "", TwitterAccount.sanitize_handle("")
  end

  test "get_tweets respects max tweet limit" do
    twitter_account = twitter_accounts :lotsoftweets
    assert_equal TwitterAccount::MAX_TWEET_COUNT, twitter_account.get_tweets.length
  end
end
