class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show edit update destroy ]

  def all_children2(level=0)
    children_array = []
    level +=1
      #must use "all" otherwise ActiveRecord returns a relationship, not the array itself
    self.children.all.each do |child|
      children_array << "&nbsp;" * level + tag.name
      children_array << child.all_children2(level)
    end
      #must flatten otherwise we get an array of arrays. Note last action is returned by default
    children_array = children_array.flatten
  end

  def index
    @tags = Tag.all
    @tag= Tag.new
  end

  def show
    @tag = Tag.find(params[:id])
    @novines = @tag.novines.order('created_at DESC')
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to tag_url(@tag), notice: "Tag was successfully created." }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to tag_url(@tag), notice: "Tag was successfully updated." }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url, notice: "Tag was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name, :parent_id)
    end
end
