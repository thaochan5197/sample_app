class FollowingsController < ApplicationController
  def index 
    @title = t "following"
    @user = User.find_by id: params[:id]
    @users = @user.following.page params[:page]
    render "users/show_follow"
  end
end
