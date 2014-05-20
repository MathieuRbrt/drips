class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:moderate, :new, :create, :edit, :update]
  before_filter :authorize_admin, only: [:moderate, :edit, :update, :destroy, :publish_post]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.approved.order("created_at DESC")
  end

  # GET /moderate
  def moderate
    @posts = Post.not_approved.order("created_at DESC")
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
     @post = Post.find(params[:id])
    if @post.approved? || current_user.admin?
      return
    else
      redirect_to root_url
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end


  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if current_user.admin?
      @post.approved = true
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def publish_post
      @post = Post.find(params[:id])
      @post.update_attribute(:approved, true)
      redirect_to :back, :notice => "Post published!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:location, :city, :picture, :user_id, :artist_id, :approved, :latitude, :longitude)
    end
end
