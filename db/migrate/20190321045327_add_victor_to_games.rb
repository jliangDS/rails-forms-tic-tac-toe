class AddVictorToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :victor, :string
  end
end
