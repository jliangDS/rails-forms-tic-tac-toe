class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create
    redirect_to game_play_path(@game)
  end
  
  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.turns.build(
      mark: @game.get_mark_for_turn,
      board_index: game_params[:selected_board_index]
    ).save

    redirect_to game_play_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:selected_board_index)
  end
end
