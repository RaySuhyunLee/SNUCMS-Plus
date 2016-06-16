module IssuesHelper
  def render_issue_link(text)
    result = text.gsub(@regex[:issue_link]) do
      @linked_issue =  Issue.where("have_issue_id = ? AND have_issue_type = ? AND parent_issue_id = ?", @issue.have_issue_id, @issue.have_issue_type, $1).first
      if @linked_issue != nil
        if @parent_name == "Course"
          '[#' + $1 + ' ' + @linked_issue.title + '](' + course_issue_path(@parent.id, $1) + ')'
        elsif @parent_name == "User"
          '[#' + $1 + ' ' + @linked_issue.title + '](' + profile_issue_path($1) + ')'
        end 
      else 
        '#' + $1
      end
    end
  end
end
