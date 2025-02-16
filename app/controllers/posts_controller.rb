class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.ordered
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      respond_to do |format|
        format.html {redirect_to posts_path, notice: "post successfully!"}
        format.turbo_stream
      end
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
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy!
    respond_to do |format|
      puts "FORMAT IS #{format}"
      format.html {redirect_to @post, notice: "Pos deleted successfully!"}
      format.turbo_stream
    end
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
