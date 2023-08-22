class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: %i[ show edit update destroy ]

  def index
    #@blog_posts = BlogPost.all.order('created_at DESC')
    @blog_posts = BlogPost.in_order_of(:status, %w[incomplete complete])
    @pagy, @blog_posts = pagy(@blog_posts)
    if params[:query].present?
      @blog_posts = BlogPost.where("title LIKE ?", "%#{params[:query]}%")
    #else
    end

    if turbo_frame_request?
      render partial: "blog_posts",
      locals: { blog_posts: @blog_posts }
    else
      render :index
    end
  rescue Pagy::OverflowError
    #redirect_to root_path(page: 1)
    params[:page] = 1
    retry
  end

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def edit
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)

    respond_to do |format|
      if @blog_post.save
        format.turbo_stream
        format.html { redirect_to blog_post_url(@blog_post),
          notice: "Blog post was successfully created." }
        #format.json { render :show, status: :created, location: @blog_post }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(
          "#{helpers.dom_id(@blog_post)}_form", partial: "form",
          locals: { blog_post: @blog_post }) }
        format.html { render :new, status: :unprocessable_entity }
        #format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog_post.update(blog_post_params)
        format.html { redirect_to blog_post_url(@blog_post),
          notice: "Blog post was successfully updated." }
        #format.json { render :show, status: :ok, location: @blog_post }
      else
        format.turbo_stream { render turbo_stream:
          turbo_stream.replace("#{helpers.dom_id(@blog_post)}_form",
          partial: "form", locals: { blog_post: @blog_post }) }
          format.html { render :edit, status: :unprocessable_entity }
        #format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog_post.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream:
        turbo_stream.remove("#{helpers.dom_id(@blog_post)}_item") }
      format.html { redirect_to blog_posts_url,
        notice: "Blog post was successfully destroyed." }
      #format.json { head :no_content }
    end
  end

  private
    def set_blog_post
      @blog_post = BlogPost.find(params[:id])
    end

    def blog_post_params
      params.require(:blog_post).permit(:title,
        :body, :publish, :status)
    end
end
