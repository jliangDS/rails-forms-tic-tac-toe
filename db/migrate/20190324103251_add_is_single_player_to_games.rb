class AddIsSinglePlayerToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :is_single_player, :boolean
  end
end
