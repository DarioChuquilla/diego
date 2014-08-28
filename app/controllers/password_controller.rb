class PasswordController < Devise::PasswordsController
  skip_before_filter :require_no_authentication, :only => [:new, :create, :edit, :update]
  skip_before_filter :assert_reset_token_passed, :only => :edit
  def edit
    super
  end
  def update
    super
  end
  def new
    super
  end
  def create
    super
  end

end
