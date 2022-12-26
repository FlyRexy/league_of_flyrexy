# frozen_string_literal: true

# controller for teams and matches
class TeamsController < ApplicationController
  before_action :admin, only: %i[new create]

  def index
    @fav_names = Favorite.where(user: current_user).map { |favor| favor.team.name }
  end

  def show
    @team = Team.find(params[:team])
  end

  def new
    @team = Team.new
  end

  def create
    new_params = params.permit(:name, :players, :coach, :subs, :shortname, :region, :logo)
    new_params[:subs] = new_params[:subs]&.split
    new_params[:players] = new_params[:players].split
    @team = Team.new(new_params)
    return unless @team.save

    redirect_to tournament_new_path, notice: "#{@team.name} была добавлена в БД!"
    # else
    #   redirect_to tournament_new_path, notice: 'Что-то пошло не так...'
  end

  def update
    @team = Team.find(params[:team])
    @favorite = Favorite.where(team: @team, user: current_user)
    Favorite.create(team: @team, user: current_user) if @favorite == []
    @favorite.destroy_all
    respond_to do |format|
      format.html         { render :update }
      format.turbo_stream { render :update }
    end
  end
end
