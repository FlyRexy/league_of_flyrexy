module MatchesHelper
  require 'nokogiri'
  require 'open-uri'

  def self.show_favorite(favorite, user)
    if favorite
      @matches_eu = Array.new
      @matches_ru = Array.new
      fav_teams = Favorite.where(user: user).map { |fav| fav.team.shortname}
      @matches = Match.all.order(:id)
      @matches.each do |match|
        if fav_teams.include? match.team1 or fav_teams.include? match.team2[2..-1] or fav_teams.include? match.team1[0..-3]
          if match.region == "LEC"
            @matches_eu.push(match)
          else
            @matches_ru.push(match)
          end
        end
      end
    else
      @matches_ru = Match.where(region: 'LCL').order(:id)
      @matches_eu = Match.where(region: 'LEC').order(:id)
    end
    [@matches_eu, @matches_ru]
  end

  def self.update_cis
    url = 'https://lol.fandom.com/wiki/LCL/2021_Season/Summer_Season'
    @doc = Nokogiri::HTML(URI.open(url))
    @team1 = Array.new
    @time = Array.new
    @team2 = Array.new
    @result = Array.new
    @team_score = Array.new
    @doc.css('td.matchlist-team1.ml-team.teamhighlight.teamhighlighter').each do |link|
      @team1.push(link.content.html_safe)
    end
    @doc.css('td.matchlist-time-cell.plainlinks.ofl-toggle-2-2.ofl-toggler-2-all span.ofl-toggle-3-2.ofl-toggler-3-all a span').each do |link|
      @time.push(TeamsHelper.time_transform(link.content.html_safe.split(',')))
    end
    @doc.css('td.matchlist-team2.ml-team.teamhighlight.teamhighlighter').each do |link|
      @team2.push(link.content.html_safe)
    end
    @doc.css('td.matchlist-score.teamhighlight.teamhighlighter.matchlist-winner-score.ofl-toggle-2-1.ofl-toggler-2-all @data-teamhighlight').each do |link|
      @result.push(Team.find_by_name(link.content.html_safe.split('.')[0])&.shortname)
    end
    @doc.css('table.wikitable2.standings td').each do |link|
      @team_score.push(link.content)
    end
    i = 5
    Result.where(region: 'LCL').delete_all
    (1..8).each do |_index|
      Result.create(name: @team_score[i], score: @team_score[i + 1], team: Team.find_by_name(@team_score[i][2..-1]), region: "LCL")
      i += 5
    end
    [@team1, @team2, @time, @result, @team_score]
  end

  def self.update_eur
    url = 'https://lol.fandom.com/wiki/LEC/2023_Season/Winter_Season'
    @doc = Nokogiri::HTML(URI.open(url))
    @team1 = Array.new
    @time = Array.new
    @team2 = Array.new
    @result = Array.new
    @team_score = Array.new
    @doc.css('td.matchlist-team1.ml-team.teamhighlight.teamhighlighter span.teamname').each do |link|
      @team1.push(link.content.html_safe)
    end
    @doc.css('td.matchlist-time-cell.plainlinks span.ofl-toggle-3-2.ofl-toggler-3-all a.external.text span').each do |link|
      @time.push(time_transform(link.content.html_safe.split(',')))
    end
    @doc.css('td.matchlist-team2.ml-team.teamhighlight.teamhighlighter').each do |link|
      @team2.push(link.content.html_safe)
    end
    @doc.css('td.matchlist-score.teamhighlight.teamhighlighter.matchlist-winner-score.ofl-toggle-1-1.ofl-toggler-1-all @data-teamhighlight').each do |link|
      @result.push(Team.find_by_name(link.content.html_safe)&.shortname)
    end
    @doc.css('table.wikitable2.standings td').each do |link|
      @team_score.push(link.content)
    end
    i = 3
    Result.where(region: 'LEC').delete_all
    (1..10).each do |_index|
      Result.create(name: @team_score[i], score: @team_score[i + 1], team: Team.find_by_name(@team_score[i][2..-1]), region: "LEC")
      i += 5
    end
    p @time
    [@team1, @team2, @time, @result, @team_score]
  end

  def self.time_transform(time)
    time.map!(&:to_i)
    time = DateTime.new(time[0], time[1], time[2], time[3], time[4])
    time
  end
end

