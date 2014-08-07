class SessionsController < Devise::SessionsController
  skip_before_filter :require_no_authentication, :only => [:new, :create]
  
  def new
    session[:return_to] ||= request.referrer
    super
  end
  
  def create
    login_process do
      super
    end
  end
  
  def destroy
    super
    cookies[:auth_token] = nil
  end
  
  private
  
    def after_sign_in_path_for(resource)
      previous_url = session[:return_to]
      session[:return_to] = nil
      previous_url || root_url
    end
    
  
end