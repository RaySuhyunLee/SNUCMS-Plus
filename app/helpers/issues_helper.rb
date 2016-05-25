module IssuesHelper
  def render_issue_link(text)
    result = text.gsub(@regex[:issue_link]) do
      '[issue ' + $1 + '](' + course_issue_path(@parent.id, $1) + ')'
    end
  end
end
