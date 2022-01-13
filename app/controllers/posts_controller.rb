class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /users/:user_id/posts
  def index
    # Prevent SQL injection https://www.netsparker.com/blog/web-security/sql-injection-ruby-on-rails-development/
    # Use:
    # - Explicit attributes: Post.where(user_id: params[:user_id])
    # - Dynamic finder methods: Post.find_by_user_id
    # Dont' use:
    # - Arbitrary string queries: User.where("name = '#{params[:name]'")
    @posts = Post.where(user_id: params[:user_id])

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /users/:user_id/posts
  def create
    @post = Post.new(post_params)
    @post.user_id = params[:user_id]

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:text, :user_id)
    end
end
