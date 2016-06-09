class HomeController < ApplicationController
  def index
    @resource
  end

  def load_recent_timeline
    offset = Integer(params['offset'])
    how_many = Integer(params['how_many'])
    user = current_user
    load_max = 10
    course_ids = []
    user.courses.find_each do |course|
      course_ids.append(course.id)
    end
    issues = Issue
      .where({have_issue_type: "Course", have_issue_id: course_ids})
      .order(created_at: :desc)
      .offset(offset)
      .take([how_many, load_max].min)

    data = prettify(issues)

    respond_to do |format|
      format.all { render json: {issues: data} }
    end
  end

  def load_subscription_timeline
    offset = Integer(params['offset'])
    how_many = Integer(params['how_many'])
    user = current_user
    load_max = 10
    issues = user.issues.
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
      puts "id: #{issue.id}, have_issue_type: #{issue.have_issue_type}"
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
        created_at: issue.created_at
      })
    end

    return data
  end
end
