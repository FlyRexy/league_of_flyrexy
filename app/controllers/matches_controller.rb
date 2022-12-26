# frozen_string_literal: true

# control all matches and adding them to DB
class MatchesController < ApplicationController
  before_action :admin, only: %i[update_ru update_eu]
  before_action :teams_init, only: %i[index favorite_matches]

  def index
    @matches_ru = Match.where(region: 'LCL').order(:id)
    @matches_eu = Match.where(region: 'LEC').order(:id)
  end

  def favorite_matches
    @favorite = !params[:fav].to_i.zero?
    @matches_eu, @matches_ru = MatchesHelper.show_favorite(@favorite, current_user)
    respond_to do |format|
      format.html         { render :favorite_matches }
      format.turbo_stream { render :favorite_matches }
    end
  end

  def update_ru
    Match.where(region: 'LCL').delete_all
    @team_blue, @team_red, @match_time, @match_result, @team_score = MatchesHelper.update_cis
    (0..@team_blue.length - 1).each do |index|
      Match.create(team1: @team_blue[index], team2: @team_red[index], time: @match_time[index],
                   result: @match_result[index], region: 'LCL')
    end
  end

  def update_eu
    Match.where(region: 'LEC').delete_all
    @team_blue, @team_red, @match_time, @match_result, @team_score = MatchesHelper.update_eur
    (0..@team_blue.length - 1).each do |index|
      Match.create(team1: @team_blue[index], team2: @team_red[index], time: @match_time[index],
                   result: @match_result[index], region: 'LEC')
    end
  end

  private

  def teams_init
    @teams = Team.all
  end
end
