class ScubosController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  before_action :set_categories, only: [ :index, :new ]
  before_action :set_hashtags, only: [ :index, :new ]

  def index
    @scubos = Scubo.all
  end

  def new
    @scubo = Scubo.new
    authorize @scubo
  end

  def create
    @scubo = Scubo.new(scubo_params)
    authorize @scubo
    @scubo.user = current_user
    if @scubo.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def scubo_params
    params.require(:scubo).permit(
      :name,
      :description,
      :category_id,
      :hashtag_id,
      :address)
  end
end
