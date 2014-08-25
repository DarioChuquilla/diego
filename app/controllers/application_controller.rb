class ApplicationController < ActionController::Base
  require 'i18n_data'
  protect_from_forgery
  before_filter :set_locale

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

  def page_not_found
    respond_to do |format|
      format.html { render template: 'home/not_found_error', layout: 'layouts/application', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
    return false
  end

  private
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end

end
