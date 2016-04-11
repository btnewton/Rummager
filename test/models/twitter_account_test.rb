require 'test_helper'

class TwitterAccountTest < ActiveSupport::TestCase
 
  test "Search does not save with if value nil" do
  	search = Search.new
  	assert_not search.save
  end

  test "New search is invalid" do
  	search = Search.new
  	assert search.is_invalid
  end

  test "Recent search is valid" do
  	search = Search.find_by author: 'TestAccount'
  	assert_not search.is_invalid
  end

end
