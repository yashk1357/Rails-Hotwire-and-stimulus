class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @post = Post.find_by(id: params[:id])
    
  end

  def new
    @post = Post.new
  end

  def update 
    @post = Post.find_by(id: params[:id])
    @post.update(post_params)
    if @post.save
      redirect_to posts_path, notice: "post successfully!"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy!
    redirect_to @post, notice: "Pos deleted successfully!"
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
