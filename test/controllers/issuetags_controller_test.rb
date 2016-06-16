require 'test_helper'

class IssuetagsControllerTest < ActionController::TestCase
  setup do
    @issuetag = issuetags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:issuetags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create issuetag" do
    assert_difference('Issuetag.count') do
      post :create, issuetag: { name: @issuetag.name }
    end

    assert_redirected_to issuetag_path(assigns(:issuetag))
  end

  test "should show issuetag" do
    get :show, id: @issuetag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @issuetag
    assert_response :success
  end

  test "should update issuetag" do
    patch :update, id: @issuetag, issuetag: { name: @issuetag.name }
    assert_redirected_to issuetag_path(assigns(:issuetag))
  end

  test "should destroy issuetag" do
    assert_difference('Issuetag.count', -1) do
      delete :destroy, id: @issuetag
    end

    assert_redirected_to issuetags_path
  end
end
