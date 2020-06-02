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

  def edit
  end
end
