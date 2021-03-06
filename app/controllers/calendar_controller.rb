class CalendarController < ApplicationController
  def show
    @issue_all = Issue.all
    @issues = []

    @issue_all.each do |i|
      @user = current_user
      unless i.due.nil?
        if i.have_issue_type.eql? "Course"
          @parent = Course.find_by_id(i.have_issue_id)
          if @user.courses.include? @parent
            @issues.append(i)
          end
        elsif i.have_issue_type.eql? "User"
          if @user.issues.include? i
            @issues.append(i)
          end
        end
      end
    end
  end
end
