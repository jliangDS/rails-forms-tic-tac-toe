class Game < ApplicationRecord
  has_many :turns
  @board = []

  def state
    self.turns.each do |turn|
      update_board_with_turn(turn)
    end
  end

  def state=(turn)
    update_board_with_turn(turn)
  end

  private

  def update_board_with_turn(turn)
    @board[turn.board_index] = turn.id % 2 == 0 ? 'O' : 'X'
  end
end
