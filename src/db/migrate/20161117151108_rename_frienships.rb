class RenameFrienships < ActiveRecord::Migration[5.0]
  def change
    rename_table :friend_ships, :friendships
  end
end
