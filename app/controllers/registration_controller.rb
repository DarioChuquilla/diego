class RegistrationController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, :only => [:new, :create]
  def new
    @user= User.new
    if params[:type] == 'motel'
      @user.hotels.build
    end
  end

  def create
    User.transaction do
      Hotel.transaction do
        begin
          @user = User.new
          @user.username = params[:user][:username]
          @user.email = params[:user][:email]
          @user.password = params[:user][:password]
          @user.password_confirmation =params[:user][:password_confirmation]
          @user.role = params[:type] == 'motel' ? 'hotel' : 'client'
          @user.save
          if params[:type] == 'motel'
            @hotel = Hotel.new
            @hotel.name = params[:user][:hotels][:name]
            @hotel.description = params[:user][:hotels][:description]
            @hotel.user_id = @user.id
            @hotel.save
          end
          
          redirect_to root_path
        rescue Exception => e
          p "A BIG ERROR!!! #{e.inspect}"
          User.connection.rollback_db_transaction
          Hotel.connection.rollback_db_transaction
          render :action => "new"
        end
      end
    end
  end

end