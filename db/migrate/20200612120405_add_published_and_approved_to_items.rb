class AddPublishedAndApprovedToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :published, :boolean, default: true
    add_column :items, :approved, :boolean, default: false
  end
end
