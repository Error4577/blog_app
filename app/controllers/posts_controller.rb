class PostsController < ApplicationController

  before_action :move_to_index, except: [:index, :show]

  def index
    # @posts = Post.order("id DESC").page(params[:page]).per(5)
    @posts = Post.includes(:user).page(params[:page]).per(5).order("id DESC")
  end

  def new
  end

  def create
    Post.create(title: post_params[:title], text: post_params[:text], user_id: current_user.id)
    # Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy if post.user_id == current_user.id
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.update(post_params)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.permit(:title, :text)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
