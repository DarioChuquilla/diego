class RegistrationController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, :only => [:new, :create]
  
  def new
    if (request.referrer == billing_url || request.referrer == update_billing_url)
      session[:return_to] = billing_url
    elsif request.referrer == guest_login_url
      session[:return_to] = shipping_url
    else
      session[:return_to] = nil
    end
    super
  end
  
  def create
    login_process do
      super
    end
  end
  
  protected
  
    def after_sign_up_path_for(resource)
      session[:return_to] || root_url
    end
  
end