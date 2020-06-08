class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :map ]
  before_action :set_categories, only: [ :index, :new, :create, :map ]
  before_action :set_hashtags, only: [ :index, :map ]

  def index
    @items = policy_scope(Item)
    @items = @items.filter_by_category(params[:category]) if params[:category].present?
    @items = @items.filter_by_hashtag(params[:hashtag]) if params[:hashtag].present?
    @items = @items.page(params[:page])
  end

  def map
    authorize(Item)
    @items = policy_scope(Item).geocoded
    @markers = @items.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end

  def new
    @item = Item.new
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    authorize @item
    @item.user = current_user
    @item.hashtag = find_or_create_hashtag(params.dig(:item, :hashtag))
    if @item.save
      redirect_to root_path
    else
      @item.hashtag = nil
      render :new
    end
  end

  def edit
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
      :address)
  end
end
