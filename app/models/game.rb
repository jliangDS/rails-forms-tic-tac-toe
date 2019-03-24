class Game < ApplicationRecord
  has_many :turns

  def selected_board_index
  end

  def board
    board = []
    self.turns.each do |turn|
      board[turn.board_index] = turn.mark if turn.board_index
    end

    return board
  end

  def get_mark_for_turn
    if self.turns.size % 2 == 0
      return 'X'
    else
      return 'O'
    end
  end
end
