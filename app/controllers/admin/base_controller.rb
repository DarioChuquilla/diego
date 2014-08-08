class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin!

  private
  
  def authenticate_admin!
    authenticate_user!
  end
end