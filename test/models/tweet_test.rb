require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  
  test "detect retweet true" do 
  	tweet = tweets(:singervehicles1)
  	assert tweet.retweet?
  end

  test "detect retweet false" do
  	tweet = tweets(:elonmusk1)
  	assert_not tweet.retweet?
	end


end
