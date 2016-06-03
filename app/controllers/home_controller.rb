class HomeController < ApplicationController
  def index
    @resource
  end

  def load_timeline
    offset = Integer(params['offset'])
    how_many = Integer(params['how_many'])
    user = current_user
    load_max = 10
    @issues = user.issues.offset(offset).take([how_many, load_max].min)

    respond_to do |format| 
      format.all { render json: {issues: @issues} }
    end
  end
end
