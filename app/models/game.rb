class Game < ApplicationRecord
  has_many :turns
  @board = []
  @is_single_player

  def is_single_player
    @is_single_player
  end

  def is_single_player=(is_single_player)
    @is_single_player = is_single_player
  end

  def board
    self.turns.each do |turn|
      update_board_with_turn(turn)
    end
  end

  def board=(turn)
    update_board_with_turn(turn)
  end

  private

  def update_board_with_turn(turn)
    @board[turn.board_index] = turn.id % 2 == 0 ? 'O' : 'X'
  end
end
