class HomeController < ApplicationController
  def index
    @resource
  end

  def load_timeline
    offset = Integer(params['offset'])
    how_many = Integer(params['how_many'])
    user = current_user
    load_max = 10
    issues = user.issues.offset(offset).take([how_many, load_max].min)
    
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
        title: issue.title,
        issue_url: issue_url,
        parent_title: parent,
        parent_url: parent_url,
        updated_at: issue.updated_at
      })
    end

    respond_to do |format| 
      format.all { render json: {issues: data} }
    end
  end
end
