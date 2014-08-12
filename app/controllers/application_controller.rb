class ApplicationController < ActionController::Base
  protect_from_forgery

  def login_process
    p "ApplicationController::login_process"
    yield
    if user_signed_in?
      logger.info "user signed in successfully"
      session[:user_id] = current_user.id
      session[:logged_in_by_password] = 'yes'
      current_user.current_sign_in_at = 1.second.ago.change(offset: "+0000")
      if params[:user][:remember_me] == "1"
        cookies.permanent.signed[:auth_token] = {
          :value => current_user.remember_token
        }
      end
    end
    
  end

end
