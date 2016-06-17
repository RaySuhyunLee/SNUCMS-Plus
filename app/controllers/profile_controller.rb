class ProfileController < ApplicationController
  include ApplicationHelper

  def index
  end

  # POST /profile/update_desc
  def update_desc
    current_user.update_attribute(:description, params[:desc])
    render plain: current_user.description
  end

  def load_subscription_timeline
    offset = Integer(params['offset'])
    how_many = Integer(params['how_many'])
    user = current_user
    load_max = 10
    issues = user.subscribing_issues
      .order(created_at: :desc)
      .offset(offset)
      .take([how_many, load_max].min)

    data = prettify(issues)

    respond_to do |format|
      format.all { render json: {issues: data} }
    end
  end

private

  def prettify(issues)
    data = []
    issues.each do |issue|
      parent = ""
      parent_url = ""
      issue_url = ""
      if issue.have_issue_type.eql? 'Course'
        parent = Course.find(issue.have_issue_id).title
        issue_url = course_issue_path(issue.have_issue_id, issue.parent_issue_id)
        parent_url = course_path(issue.have_issue_id)
      elsif issue.have_issue_type.eql? 'Group'
        parent = Group.find(issue.have_issue_id).title
      end

      data.append({
        id: issue.id,
        title: issue.title,
        issue_id: issue.parent_issue_id,
        issue_url: issue_url,
        parent_title: parent,
        parent_url: parent_url,
        created_at: prettify_time(issue.created_at)
      })
    end

    return data
  end

end


