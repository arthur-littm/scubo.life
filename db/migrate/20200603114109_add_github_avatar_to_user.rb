class AddGithubAvatarToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :github_avatar, :string
  end
end
