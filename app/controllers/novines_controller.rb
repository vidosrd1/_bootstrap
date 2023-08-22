class NovinesController < ApplicationController
  before_action :set_novine, only: %i[ show edit update destroy ]

  def is_user_admin
    redirect_to(action: :index) unless
    current_user.try(:is_admin?)
    return false
  end

  def index
    #if params[:tag]
    #  @tag = Tag.find_by(name: params[:tag])
    #  @novines = Novine.where(tag_id: @tag.id)
    if params[:tag_id]
      Tag.find(id).novines
    else
      @novines = Novine.all.order('created_at DESC')
    #@novine_titles = Novine.first(10)
    #@tags = Tag.all
    end
    #@novines = novines.includes(:children_categories)    @pagy, @novines =
    @pagy, @novines =
    pagy(@novines)
    if params[:query].present?
      @ovines = Novine.where("title LIKE ?", "%#{params[:query]}%")
    end

    if turbo_frame_request?
      render partial: "novines",
      locals: { novines: @novines }
    else
      render :index
    end
  rescue Pagy::OverflowError
    #redirect_to root_path(page: 1)
    params[:page] = 1
    retry
  end

  def show
    #@novine = Novine.find(params[:id])
  end

  def new
    @novine = Novine.new
    #@novine = Tagging.new    #@novine.tags.build
    #@novine.novine_tags.build.build_tag
    #@tags = Tag.find(:all)
    @tags = Tag.all
    #novine_tag = @novine.novine_tags.build()
    #@novine_tags = @novine.tags.all
    #@novine.novine_tags.build.build_tag
    3.times do
      #novine_tag = @novine.novine_tags.build()
    end
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?',
      "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  def edit
  end

  def create
    @novine = Novine.new(novine_params)
    #tag_arr = params[:tag].split(',')

    #Novine.transaction do
    #  if @novine.save
    #    tag_arr.each do |name|
    #      novine.tags.find_or_create_by(name: name)
    #    end
    #  end
    #end

    respond_to do |format|
      if @novine.save
        format.html { redirect_to novine_url(@novine), notice: "Novine was successfully created." }
        format.json { render :show, status: :created, location: @novine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @novine.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @novine.update(novine_params)
        format.html { redirect_to list_url(@novine),
          notice: "Novine was successfully updated." }
        format.json { render :show, status: :ok, location: @novine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @novine.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @novine.destroy

    respond_to do |format|
      format.html { redirect_to novines_url, notice: "Novine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def create_or_delete_novines_tags(novine, tags)
      post.taggables.destroy_all
      tags = tags.strip.split(',')
      tags.each do |tag|
        novine.tags << Tag.find_or_create_by(name: tag)
      end
    end

    def set_novine
      @novine = Novine.find(params[:id])
      #@novines = novines.includes(:children_categories)
    end

    #@novine_params = params[:novine]
    #  novine_params[:tag_ids].each do |tag|
    #    @novine_tag = @novine_tags.build(
    #      'novine_id'=>@novine.id,'tag_id'=>tag)
    #    @novine_tag.save
    #end

    def novine_params
      params.require(:novine).permit(#:user_id,
        :title, :name, #:tag_id,
        :image, :publish,
        :body, pictures: [],
        tag_ids: []
      ).with_defaults(user: current_user)
    end

    def current_user
      User.first
    end
end
