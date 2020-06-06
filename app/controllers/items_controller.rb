class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  before_action :set_categories, only: [ :index, :new, :create ]
  before_action :set_hashtags, only: [ :index ]

  def index
    @items = Item.all
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
