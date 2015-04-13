class PostsController < ApplicationController

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
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "updated!"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:alert] = "deleted!"
    redirect_to :action => :index
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
