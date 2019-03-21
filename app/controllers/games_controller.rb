class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create
  end

  def edit
  end

  def update
  end

  private

  def game_params
    params.require(:game).permit(:)
  end
end
