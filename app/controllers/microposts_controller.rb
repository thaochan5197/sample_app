class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: %i(destroy)

  def create
    @micropost = current_user.microposts.build micropost_params

    if @micropost.save
      flash[:success] = t ".post_created"
      redirect_to root_url
    else
      @feed_items = current_user.feed.sorted.page(params[:page])
                                .per Settings.number_of_post
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".post_deleted"
      redirect_to request.referrer || root_url
    else
      flash.now[:danger] = t ".can_not_delete"
      render "static_pages/home"
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :picture
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]

    return if @micropost
    flash[:danger] = t ".not_found"
    redirect_to root_url unless @micropost
  end
end
