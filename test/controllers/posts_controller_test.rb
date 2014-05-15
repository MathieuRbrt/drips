require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should be redirected when not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render the new page when logged in" do
    sign_in users(:mathieu)
    get :new
    assert_response :success
  end

  test "should be logged in to create a post" do
    post :create, post: { infos: @post.infos, location: @post.location }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should create post when logged in" do
    sign_in users(:mathieu)
    assert_difference('Post.count') do
      post :create, post: { infos: @post.infos, location: @post.location }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end


  test "should redirect post edit when not logged in" do
    get :edit, id: @post
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should get edit when logged in" do
    sign_in users(:mathieu)
    get :edit, id: @post
    assert_response :success
  end

  test "should redirect post update when not logged in" do
    patch :update, id: @post, post: { infos: @post.infos, location: @post.location }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should update post when logged in" do
    sign_in users(:mathieu)
    patch :update, id: @post, post: { infos: @post.infos, location: @post.location }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end
