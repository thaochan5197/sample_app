class PasswordResetsController < ApplicationController
  before_action :fetch_current_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase

    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".notice"
      redirect_to root_url
    else
      flash.now[:danger] = t ".invalid_email"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.error.add :password, t(".empty_error")
      render :edit
    elsif @user.update user_params
      log_in @user
      flash[:success] = t ".reset_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def fetch_current_user
    @user = User.find_by email: params[:email]
    
    return if @user
    flash[:danger] = t ".danger"
    redirect_to root_url
  end

  def valid_user
    return redirect_to root_url unless @user&.activated? &&
                                       @user.authenticated?(:reset, params[:id])
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t ".reset_expired"
    redirect_to new_password_reset_url
  end
end
