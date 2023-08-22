class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy ]

  def pagy_url_for(pagy, page, absolute: false, html_escaped: false)  # it was (page, pagy) in previous versions
    params = request.query_parameters.merge(pagy.vars[:page_param] => page, only_path: !absolute )
    html_escaped ? url_for(params).
    gsub('&', '&amp;') : url_for(params)
  end

  def index
    @lists = List.all#.order('created_at DESC')
    #@lists = List.in_order_of(:status,
    #  %w[incomplete complete])
    #@pagy, @lists = pagy(collection, params: ->(params)
    #{ params.except('not_useful').merge!('custom' => 'useful') })
    @pagy, @lists =
    pagy(@lists)
    if params[:query].present?
      @lists = List.where("title LIKE ?", "%#{params[:query]}%")
    end

    if turbo_frame_request?
      render partial: "lists",
      locals: { lists: @lists }
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
    @list = List.new
  end

  def edit
  end

  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        #format.turbo_stream
        format.html { redirect_to list_url(@list),
          notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        #format.turbo_stream { render turbo_stream: turbo_stream.replace(
        #  "#{helpers.dom_id(@list)}_form", partial: "form",
        #  locals: { list: @list }) }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to list_url(@list),
          notice: "List was successfully updated." }
        format.json { render :show, status: :ok, location: @list }
      else
        #format.turbo_stream { render turbo_stream:
        #  turbo_stream.replace("#{helpers.dom_id(@list)}_form",
        #  partial: "form", locals: { list: @list }) }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list.destroy

    respond_to do |format|
      #format.turbo_stream { render turbo_stream:
      #  turbo_stream.remove("#{helpers.dom_id(@list)}_item") }
      format.html { redirect_to lists_url,
        notice: "List was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:title,
        :artist,
        :image, :body, :publish, :art_id)
    end
end
