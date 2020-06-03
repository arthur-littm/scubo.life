class RenameScuboToItems < ActiveRecord::Migration[6.0]
  def change
    rename_table :scubos, :items
  end
end
