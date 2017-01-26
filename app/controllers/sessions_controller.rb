class SessionsController < ApplicationController
  include ApplicationHelper
  include SessionsHelper

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_deets[:email])
    if @user && @user.authenticate(user_deets[:password])
        login_user
      if admin?
        flash[:notice] = "Login Successful!"
        redirect_to users_path
      else
        flash[:notice] = "Login Successful!"
        redirect_to profile_path(@user)
      end
    else
      flash[:alert] = "Login failed"
      @errors = ["That combination of username and password can't be found"]
      redirect_to :login
    end
  end

  def destroy
    flash[:notice] = "Thank's for stopping by!"
    logout_user
    redirect_to root_path
  end

private
  def user_deets
      params.require(:user).permit(:email, :password)
  end
end
