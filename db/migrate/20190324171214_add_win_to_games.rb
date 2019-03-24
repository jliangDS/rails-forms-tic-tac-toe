class AddWinToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :win, :string
  end
end
