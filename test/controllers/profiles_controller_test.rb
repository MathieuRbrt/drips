require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: users(:mathieu).profile_name
    assert_response :success
    assert_template 'profiles/show'
  end

  	test "should render a 404 on profile not found" do
		get :show, id: "doesn't exist"
    	assert_response :not_found
	end

  	test "that variables are assigned on successful profile viewing" do
		get :show, id: users(:mathieu).profile_name
    	assert assigns(:user)
    	assert_not_empty assigns(:posts)
	end

  	test "only shows the correct's user's posts" do
		get :show, id: users(:mathieu).profile_name
		assigns(:posts).each do |post|
			assert_equal users(:mathieu), post.user
		end
	end
end
