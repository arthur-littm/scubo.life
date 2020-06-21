class AddCityToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :city_id, :integer, null: true
  end
end
