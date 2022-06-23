class ApplicationController < ActionController::Base
 
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  #before_action :turbo_frame_request_variant
  #before_action :set_current_user

  include Pundit::Authorization
  include Pagy::Backend
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    
  around_filter :set_time_zone

  def set_time_zone
    if logged_in?
      Time.use_zone(current_user.time_zone) { yield }
    else
      yield
    end
  end
      
  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
  
  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
  
  def set_current_user
    Current.user = current_user
  end
  
  private
 
    def user_not_authorized
      flash[:warning] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path) 
      return
    end
  
end
