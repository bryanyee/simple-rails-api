# TODO:
# - Validate filter and order params and return an error response for invalid values
# - Prevent n+1 queries w/ eager loading

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # Resource collections concepts:
  # - Nested resources
  # - Filtering, pagination, sorting
  # - Relation chaining and lazy evaluation of sql queries
  # - Eager loading to prevent n+1 SQL queries
  # - SQL injection prevention

  # GET /users/:user_id/posts?kind=<kind>&limit=<limit>&offset=<offset>&order=<order>
  def index
    # Prevent SQL injection https://www.netsparker.com/blog/web-security/sql-injection-ruby-on-rails-development/
    # Use:
    # - Explicit attributes: Post.where(user_id: params[:user_id])
    # - Dynamic finder methods: Post.find_by_user_id
    # Dont' use:
    # - Arbitrary string queries: User.where("name = '#{params[:name]'")
    @posts = Post.where(user_id: index_params[:user_id])

    # ActiveRecord Relations are lazy evaluated and can be chained w/o firing extra SQL queries
    # https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/active-record-queries

    # FILTER
    # TODO: validate @kind param
    if index_params[:kind].present?
      @posts = @posts.where(kind: index_params[:kind])
    end

    # PAGINATE
    if index_params[:offset].present?
      @posts = @posts.offset(index_params[:offset])
    end

    if index_params[:limit].present?
      @posts = @posts.limit(index_params[:limit])
    end

    # SORT
    if index_params[:order].present?
      # asc OR desc
      # TODO: validate @order param
      @posts = @posts.order(created_at: index_params[:order])
    end

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

    # https://guides.rubyonrails.org/action_controller_overview.html#json-parameters
    # https://api.rubyonrails.org/v7.0.2.3/classes/ActionController/ParamsWrapper.html
    # For Content-Type="application/json" requests, params in the request body are made available in params[:resource]
    def post_params
      params.require(:post).permit(:text)
    end

    def index_params
      params.permit(:user_id, :kind, :offset, :limit, :order)
    end
end
