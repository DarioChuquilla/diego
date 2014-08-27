class ApplicationController < ActionController::Base
  # check_authorization :unless => :do_not_check_authorization?
  rescue_from CanCan::AccessDenied do |exception|
    # redirect_to root_url, :alert => exception.message
    redirect_to(not_found_page_path, :alert => exception.message) and return
  end
  require 'i18n_data'
  protect_from_forgery
  before_filter :set_locale

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

  def do_not_check_authorization?
    respond_to?(:devise_controller?)
  end

end
