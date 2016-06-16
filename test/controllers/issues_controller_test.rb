require 'test_helper'

class IssuesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    user = User.find(1)
    sign_in user
    @issue = issues(:one)
    @course = courses(:one)
  end
  
  test "should get index" do
    get :index, course_id: @course.id
    assert_response :success
    assert_not_nil assigns(:issues)
  end

  test "should get new" do
    get :new, course_id: @course.id
    assert_response :success
  end

  test "should create issue" do
    assert_difference('Issue.count') do
      post :create, course_id: @course.id, issue: { title: @issue.title }
    end
  
    assert_redirected_to course_issues_path(@course.id)
  end

  test "should show issue" do
    post :create, course_id: @course.id, issue: { title: @issue.title }
    get :show, course_id: @course.id, id: 1  # FIXME hard coding is not a good practice
    assert_response :success
  end
 
  test "should update issue" do
    post :create, course_id: @course.id, issue: { title: @issue.title }
    patch :update, course_id: @course.id, id: 1, issue: { title: @issue.title }
    assert_redirected_to course_issue_path(@course.id, 1)
  end

  test "should destroy issue" do
    post :create, course_id: @course.id, issue: { title: @issue.title }
    assert_difference('Issue.count', -1) do
      delete :destroy, course_id: @course.id, id: 1
    end

    assert_redirected_to course_issues_path
  end

end
