module GamesHelper
  @@win_conditions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  # Returns 'X' or 'O' if there is a winner
  # or 'TIE' if game ended with no winners
  # or nil if game has not yet ended
  def check_for_win(game)
    return nil if game.turns.size < 5 

    xs = game.turns.where(mark: 'X').map {|turn| turn.board_index }
    os = game.turns.where(mark: 'O').map {|turn| turn.board_index }

    @@win_conditions.each do |win|
      # Check if xs or os contain indices combo that meet win condition
      if (win-xs).empty?
        return "X"
      elsif (win-os).empty?
        return "O"
      end
    end

    if game.turns.size == 9
      return "TIE"
    else
      return nil
    end
  end

  # AI Logic
  # 1. If there's two in a row, get the third for the win
  # 2. If player has two in a row, block the third
  # 3. Get a corner
  # 4. Get the center
  def do_move(game, mark)
    player = mark == 'X' ? 'O' : 'X'
    player_marks = game.turns.where(mark: player).map {|turn| turn.board_index}
    marks = game.turns.where(mark: mark).map {|turn| turn.board_index}
    i = nil

    # Look for winning move
    @@win_conditions.each do |win|
      if (win-marks).size == 1 && !game.board[(win-marks).first]
        i = (win-marks).first
      end
    end

    if !i
      # Block any potential wins for player
      @@win_conditions.each do |win|
        if (win-player_marks).size == 1 && !game.board[(win-player_marks).first]
          i = (win-player_marks).first
        end
      end
    end

    if !i
      # Prioritize corners 
      if !game.board[0] || !game.board[2] || !game.board[6] || !game.board[8]
        i = i = [0, 2, 6, 7].sample 

        while game.board[i]
          i = [0, 2, 6, 7].sample 
        end
      # Else prioritize center
      elsif !game.board[4]
        i = 4
      end
    end

    game.turns.build(mark: mark, board_index: i).save
  end
end
