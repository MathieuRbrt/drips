class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:moderate, :new, :create, :edit, :update]
  before_filter :authorize_admin, only: [:moderate, :edit, :update, :destroy, :publish_post]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  

  def like
    @post = Post.find(params[:id])

    if current_user.flagged?(@post)
      current_user.unflag(@post)
      redirect_to posts_path, :notice => "You now dislike this post"   
    else
      current_user.flag(@post, :like)
      redirect_to posts_path, :notice => "You now like this post"   
    end
  end

  # GET /posts
  # GET /posts.json
  def index
    if params[:sort]
      @posts = Post.approved.order(params[:sort])
    else
      @posts = Post.approved.order("created_at DESC")
    end
  end

  # GET /moderate
  def moderate
    @posts = Post.not_approved.order("created_at DESC")
    @suggestions = Suggestion.all
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
        if current_user.admin?
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
        else
          format.html { redirect_to @post, notice: 'Great! Your post will be moderated soon!' }
        end
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
      format.html { redirect_to moderate_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def publish_post
      @post = Post.find(params[:id])
      @post.update_attribute(:approved, true)
      redirect_to moderate_url, :notice => "Post published!"
  end

  def accept_suggestion
      @suggestion = Suggestion.find(params[:id])
      @user = @suggestion.user
      @post = @suggestion.post
      @user.increment!(:suggested, by = 1)
      @post.update_attribute(:artist_id, @suggestion.artist_id)
      @suggestion.destroy
      redirect_to :back, :notice => "Suggestion accepted!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:location, :city, :country, :picture, :user_id, :artist_id, :approved, :latitude, :longitude)
    end
end
