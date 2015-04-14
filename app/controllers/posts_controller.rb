class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_post, :only => [ :show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC')
    @posts = Post.page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "created!"
      redirect_to @post
    else
      render "new"
    end
  end

  def show
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(params[:post].permit(:title, :body))
      flash[:notice] = "updated!"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "deleted!"

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
