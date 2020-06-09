class RenameScuboRef < ActiveRecord::Migration[6.0]
  def change
    rename_column :bookmarks, :scubo_id, :item_id
    rename_column :upvotes, :scubo_id, :item_id
  end
end
