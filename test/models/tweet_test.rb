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

	

	test "get_handles returns array if multiple handles present" do
		handles = tweets(:singervehicles1).get_handles

		assert_equal handles.length, 5
		assert handles.include? 'PorscheRetail'
		assert handles.include? 'singervehicles'
		assert handles.include? 'CarSnapped'
		assert handles.include? 'PrestigeDiesels'
		assert handles.include? 'AutoPap'
	end

	test "get_handles returns 1d array if one handle present" do
		handles = tweets(:elonmusk4).get_handles

		assert_equal handles.length, 1
		assert handles.include? 'SpaceX'
	end

	test "get_handles returns empty array if no handles present" do
		handles = tweets(:elonmusk1).get_handles

		assert_equal handles.length, 0
	end

end
