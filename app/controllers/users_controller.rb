class UsersController < ApplicationController
  def new
    @user = User.new
    @user.profiles.new
    @user.profiles.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".greeting"
      redirect_to @user
    else
      @user.profiles || @user.profiles.new
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t ".warning"
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, profiles_attributes: [:address, :_destroy]
  end
end
