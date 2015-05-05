class UsersController < ApplicationController
  # before_action :check_login
  # before_action :set_user, only: [:show, :edit, :update, :destroy]
  # authorize_resource

  def new
    @user = User.new
  end

  def index
    @users = User.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def edit
  end

  def create
    #puts user_params
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: "Thank you for signing up!"
    else
      flash[:error] = "This user could not be created."
      render "new"
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to(@user, :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:role, :username, :password, :password_confirmation, :active, :user_ids => [])
  end
end