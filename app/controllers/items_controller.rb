class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :map ]
  before_action :set_categories, only: [ :index, :new, :create, :map, :edit, :update ]
  before_action :set_hashtags, only: [ :index, :map ]

  def index
    @items = policy_scope(Item).joins(:user)
    @items = @items.filter_by_category(params[:category]) if params[:category].present?
    @items = @items.filter_by_hashtag(params[:hashtag]) if params[:hashtag].present?
    @items = @items.page(params[:page])
  end

  def map
    authorize(Item)
    @items = policy_scope(Item).geocoded
    @markers = @items.map do |item|
      {
        lat: item.latitude,
        lng: item.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { item: item })
      }
    end
  end

  def new
    @item = Item.new
    authorize @item
    @markers = []
  end

  def create
    @item = Item.new(item_params)
    authorize @item
    @item.user = current_user
    @item.hashtag = find_or_create_hashtag(params.dig(:item, :hashtag, :name))
    if @item.save
      redirect_to root_path
    else
      @item.hashtag = nil
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
    authorize @item
    @markers = [ { lat: @item.latitude, lng: @item.longitude} ]
  end

  def update
    @item = Item.find(params[:id])
    authorize @item
    @item.hashtag = find_or_create_hashtag(params.dig(:item, :hashtag, :name))
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def find_or_create_hashtag(string)
    return if string.blank?
    formatted_hashtag = Hashtag.format(string)
    return Hashtag.find_or_create_by(name: formatted_hashtag)
  end

  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :category_id,
      :address,
      :photo)
  end
end
