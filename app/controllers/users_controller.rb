class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  before_action :fetch_current_user, only: %i(show edit update destroy)

  def index
    @users = User.all.page(params[:page]).per Settings.number_of_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".greeting"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    return if @user
    redirect_to root_url
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t ".success"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t ".request"
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".warning" 
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def fetch_current_user
    @user = User.find_by id: params[:id]
    flash[:danger] = t ".warning" unless @user
  end
end
