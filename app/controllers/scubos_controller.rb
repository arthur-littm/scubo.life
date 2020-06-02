class ScubosController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
  end

  def new
  end

  def edit
  end
end
