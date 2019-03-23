class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params(:is_single_player))
    redirect_to game_play_path(@game)
  end
  
  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.update(game_params(:board))
    redirect_to game_play_path(@game)
  end

  private

  def game_params(*args)
    params.require(:game).permit(*args)
  end
end
