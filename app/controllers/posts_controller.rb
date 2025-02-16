class PostsController < ApplicationController
  before_action :set_post, except: [:new, :index, :create]

  def index
    @posts = current_company.posts.ordered
  end

  def create
    @post = current_company.posts.build(post_params)
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
  end

  def edit
  end

  def new
    @post = Post.new
  end

  def update 
    @post.update(post_params)
    if @post.save
      redirect_to posts_path, notice: "post successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
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

  def set_post
    @post = current_company.posts.find_by(id: params[:id])
  end
end
