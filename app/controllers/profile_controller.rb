class ProfileController < ApplicationController
  def index
  end

  # POST /profile/update_desc
  def update_desc
    current_user.update_attribute(:description, params[:desc])
    render plain: current_user.description
  end
end
