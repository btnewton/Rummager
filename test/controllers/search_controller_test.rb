require 'test_helper'

class SearchControllerTest < ActionController::TestCase

  test "should get show" do
  	account_name = "TestAccount"
    get :show, {'id' => account_name}
    assert_response :success
    assert_not_nil assigns(:search)
  end


  test "should create search" do
	  assert_difference('Searches.count') do
	    post :create, search: {value: 'NewAccount'}
	  end
	  assert_redirected_to search_path(assigns(:search))
	end

end
