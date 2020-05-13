class RenameUsernameToGithubHandle < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :username, :github_handle
  end
end
