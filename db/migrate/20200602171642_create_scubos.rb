class CreateScubos < ActiveRecord::Migration[6.0]
  def change
    create_table :scubos do |t|
      t.string :name
      t.string :description
      t.string :address
      t.references :category, null: false, foreign_key: true
      t.references :hashtag, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
