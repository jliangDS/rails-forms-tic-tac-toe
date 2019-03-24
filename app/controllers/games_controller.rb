class GamesController < ApplicationController
  include GamesHelper

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(create_params)

    # Randomize who starts
    if @game.is_single_player
      # AI start
      if [true,false].sample
        do_move(@game, @game.get_mark_for_turn)
      end
    end

    redirect_to game_play_path(@game)
  end
  
  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    player_mark = @game.get_mark_for_turn

    # Player move
    @game.turns.build(
      mark: player_mark,
      board_index: update_params[:selected_board_index]
    ).save

    # AI move
    if @game.is_single_player
      do_move(@game, get_other_mark(player_mark))
    end

    result = check_for_win(@game)
    if result
      @game.update(victor: result[0], win: result[1])
      redirect_to game_path(@game)
    else
      redirect_to game_play_path(@game)
    end
  end

  private

  def update_params
    params.require(:game).permit(:selected_board_index)
  end

  def create_params
    params.require(:game).permit(:is_single_player)
  end

  def get_other_mark(mark)
    mark == 'X' ? 'O' : 'X'
  end
end
