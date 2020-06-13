class BookmarksController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    bookmark = Bookmark.create(item: item, user: current_user)
    authorize bookmark
    render partial: 'bookmark', locals: { item: item }
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    authorize bookmark
    item = bookmark.item
    bookmark.destroy
    render partial: 'bookmark', locals: { item: item }
  end

end
