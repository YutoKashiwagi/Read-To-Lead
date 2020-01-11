class PostsController < ApplicationController
  before_action :authenticate_user!,only: [:show,:create,:destroy]
  
  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = '投稿されました'
      redirect_to post_path(@post.id)
    else
      flash[:danger] = '投稿に失敗しました'
      redirect_to root_path
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "投稿が削除されました"
    redirect_to request.referrer || root_path
  end
  
  private
    
    def post_params
      params.fetch(:post, {}).permit(:picture)
      # params.require(:post).permit(:picture)
    end
end
