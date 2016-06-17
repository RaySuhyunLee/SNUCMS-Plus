class ApplicationController < ActionController::Base
  # filter devise parameters
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {
      |u| u.permit(:email, :password, :password_confirmation,
                   :name, :college, :major, :student_id)
    }
  end
end
