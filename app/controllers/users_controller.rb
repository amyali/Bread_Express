class UsersController < ApplicationController
  authorize_resource
  # before_action :check_login, except: [:new]
  # before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def edit
  end

  def create
    puts user_params
    @user = User.new(user_params)
    puts @user.username
    puts @user.save
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
      redirect_to(@user, :notice => "#{@user.username} was successfully updated.")
    else
      render :action => "edit"
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "successfully removed #{@user.username} from Bread Express."
    redirect_to users_url

  private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:role, :username, :password, :password_confirmation, :active, :user_ids => [])
  end
end