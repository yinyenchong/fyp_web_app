class ApplicationController < ActionController::Base
 
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    
  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
  
  private
 
    def user_not_authorized
      flash[:warning] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path) 
      return
    end
  
end
