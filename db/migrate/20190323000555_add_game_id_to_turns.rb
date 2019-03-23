class AddGameIdToTurns < ActiveRecord::Migration[5.2]
  def change
    add_column :turns, :game_id, :integer
  end
end
