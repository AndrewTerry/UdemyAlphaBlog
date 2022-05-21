class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:notice] = "Welcome, #{@user.username}, you have successfully signed up!"
      redirect_to login_path
    else
      render 'new'
    end
  end
  
  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Profile and associated articles deleted!"
    redirect_to users_path
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "Account details updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can't update someone else's profile!"
      redirect_to articles_path
    end
  end
  
end