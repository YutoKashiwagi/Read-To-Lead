# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = current_user
    @post = Post.find_by(params[:post_id])
    @user.good(@post)
    @post.create_notification_like(@user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = current_user
    @post = Post.find_by(params[:post_id])
    @user.not_good(@post)
    redirect_back(fallback_location: root_path)
  end
end
