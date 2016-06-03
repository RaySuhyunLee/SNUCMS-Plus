class HomeController < ApplicationController
  def index
    @resource
  end

  def load_timeline
    offset = params['count']
    puts "offset = #{offset}"
    user = current_user
    limit = 5
    @issues = user.issues.offset(offset).take(limit)

    respond_to do |format| 
      format.all { render json: {issues: @issues} }
    end
  end
end
