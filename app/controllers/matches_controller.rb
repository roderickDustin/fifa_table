class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end

  def new
    @match = Match.new
  end

  # TODO Add functionality to handle JS requests
  def create
    @match = Match.new(match_params)
    if @match.save
      redirect_to root_url, notice: "#{@match.winning_player.name}'s victory added!"
    else
      render action:'new'
    end
  end

  def show
    @match = Match.find(params[:id])
  end

  def edit
  end

  def destroy
    @match = Match.find(params[:id])
    winner = @match.winning_player.name
    loser = @match.losing_player.name
    @match.destroy!
    flash[:alert] = "#{winner}'s win against #{loser} has been deleted"
    redirect_to players_url
  end

  private

    def match_params
      params.require(:match).permit(:winning_player_id, :losing_player_id)
    end
end
