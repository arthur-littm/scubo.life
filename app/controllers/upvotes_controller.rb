class UpvotesController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    upvote = Upvote.create(item: item, user: current_user)
    authorize upvote
    render partial: 'upvote', locals: { item: item }
  end

  def destroy
    upvote = Upvote.find(params[:id])
    authorize upvote
    item = upvote.item
    upvote.destroy
    render partial: 'upvote', locals: { item: item }
  end
end
