class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :map, :show ]
  before_action :set_categories, only: [ :index, :new, :create, :map, :edit, :update ]
  before_action :set_hashtags, only: [ :index, :map ]
  before_action :set_cities, only: [ :index, :map ]

  def index
    @items = sort(policy_scope(Item))
    @items = @items.where(user_id: params[:user]) if params[:user]
    @items = @items.filter_by_category(params[:category]) if params[:category].present?
    @items = @items.filter_by_hashtag(params[:hashtag]) if params[:hashtag].present?
    @items = @items.filter_by_city(params[:city]) if params[:city].present?

    @items = @items.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    authorize @item
    @markers = [ { lat: @item.latitude, lng: @item.longitude} ]
    render partial: 'items/show', locals: { item: @item }
  end

  def map
    authorize(Item)
    @items = policy_scope(Item).geocoded
    @items = @items.filter_by_category(params[:category]) if params[:category].present?
    @items = @items.filter_by_hashtag(params[:hashtag]) if params[:hashtag].present?
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
    @item.city = find_or_create_city(params.dig(:item, :city, :name))
    @item.approved = true if current_user.admin
    if @item.save
      flash[:notice] = "Item submitted for approval, wait a few minutes."
      redirect_to my_account_path
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

  def update_published
    @item = Item.find(params[:id])
    authorize @item
    @item.update(published: params[:published])
    flash[:notice] = "Item has been #{@item.published ? 'published' : 'archived'}"
    redirect_to my_account_path
  end

  private

  def sort(items)
    if params[:sort] == 'newest'
      items.joins(:user)
        .order(created_at: :desc)
    else
      items.left_joins(:upvotes)
        .group(:id)
        .order('COUNT(upvotes.id) DESC')
    end
  end

  def find_or_create_city(string)
    return if string.blank?
    return City.find_or_create_by(name: string)
  end

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
      :photo,
      :published)
  end
end
