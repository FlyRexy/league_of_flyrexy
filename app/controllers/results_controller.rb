# frozen_string_literal: true

# control standings of teams
class ResultsController < ApplicationController
  def index
    @teams = Team.all
    @result_ru = Result.where(region: 'LCL')
    @result_eu = Result.where(region: 'LEC')
  end
end
