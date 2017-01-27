class UsersController < ApplicationController
  include ApplicationHelper
  include SessionsHelper

  def index
    if admin?
      @users = User.where(is_ken: false)
    else
      flash[:not_admin] = "You do not have permission to view this page."
    end
  end

  def show
    if admin?
      @user = User.find_by(id: friend_id)
    else
      @user = User.find_by(id: session[:user_id])
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_deets)
    if @user.save
      flash[:notice] = 'Account creation successful!'
      login_user
      redirect_to profile_path(@user)
    else
      flash[:alert] = 'Account creation failed'
      @errors = @user.errors.full_messages
      render action: 'new'
    end
  end

  def destroy
    if admin?
      @user = User.find(params[:id])
      @user.destroy

      redirect_to users_path
    else
      flash[:not_admin] = "You do not have permission to view this page."
      redirect_to "/"
    end
  end

  private
  def friend_id
    params.require(:format)
    #add integer matching
  end

  def user_deets
      params.require(:user).permit(:name, :email, :password)
  end
end
