class SessionsController < ApplicationController
  before_action :fetch_current_user, only: :create

  def new; end

  def create
    if user&.authenticate(params[:session][:password])
      user_ativated? user
    else
      flash.now[:danger] = t ".danger_mess"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def fetch_current_user
    user = User.find_by email: params[:session][:email].downcase
    flash[:danger] = t ".warning" unless user
  end

  def remember_session user
    if params[:session][:remember_me] == Settings.remember_active
      remember user
    else
      forget user
    end
  end

  def user_ativated? user
    if user.activated?
      log_in user
      remember_session user
      flash[:success] = t ".success_mess"
      redirect_back_or user
    else
      flash[:warning] = t ".not_activated"
      redirect_to root_url
    end
  end
end
