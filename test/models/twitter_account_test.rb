require 'test_helper'

class TwitterAccountTest < ActiveSupport::TestCase
 
  test "Twitter account does not save with if value nil" do
  	twitter_account = TwitterAccount.new
  	assert_not twitter_account.valid?
  end

end
