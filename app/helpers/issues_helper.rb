module IssuesHelper
  def render_issue_link(text)
    result = text.gsub(@regex[:issue_link]) do
      if Issue.where("have_issue_id = ? AND have_issue_type = ? AND parent_issue_id = ?", @issue.have_issue_id, @issue.have_issue_type, $1).first != nil
        '[issue ' + $1 + '](' + course_issue_path(@parent.id, $1) + ')'
      else 
        '#' + $1
      end
    end
  end
end
