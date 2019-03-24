class AddMarkToTurns < ActiveRecord::Migration[5.2]
  def change
    add_column :turns, :mark, :string
  end
end
