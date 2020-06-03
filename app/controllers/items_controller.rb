class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  before_action :set_categories, only: [ :index, :new ]
  before_action :set_hashtags, only: [ :index, :new ]

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
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :category_id,
      :hashtag_id,
      :address)
  end
end
