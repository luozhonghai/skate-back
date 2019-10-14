require 'leaderboard'
require 'json'
class Leaderboards
  def initialize(args)

  end

  #begin single
  def self.insert_leaderboard_single(identifier, score)
    highscore_lb_single = Leaderboard.new('lb_single')
    member_60 = highscore_lb_single.member_at(60)
    rank_me = highscore_lb_single.rank_for(identifier)
    if rank_me == nil || member_60 == nil || member_60[:score] == nil || member_60[:score].to_i < score.to_i
      highscore_lb_single.rank_member(identifier, score)
      return true
    end

    return false
    #else ignore
  end

  def self.get_rank_in_single(identifier)
    highscore_lb_single = Leaderboard.new('lb_single')
    return highscore_lb_single.rank_for(identifier)
  end

  def self.get_top60_in_single()
    highscore_lb_single = Leaderboard.new('lb_single')
    return highscore_lb_single.top(60)
  end

  # end single
  #

  # begin online
  def self.insert_leaderboard_online(identifier, score, mode)
    options = Leaderboard::DEFAULT_OPTIONS
    options[:reverse] = true
    highscore_lb_online = Leaderboard.new('lb_online_' + mode, options)
    member_20 = highscore_lb_online.member_at(20)
    rank_me = highscore_lb_online.rank_for(identifier)
    if rank_me == nil || member_20 == nil || member_20[:score] == nil || member_20[:score].to_f > score.to_f
      highscore_lb_online.rank_member(identifier, score)
      return true
    end

    return false
    #else ignore
  end

  def self.get_rank_in_online(identifier, mode)
    options = Leaderboard::DEFAULT_OPTIONS
    options[:reverse] = true
    highscore_lb_online = Leaderboard.new('lb_online_' + mode,options)
    return highscore_lb_online.rank_for(identifier)
  end

  def self.get_top20_in_online(mode)
    options = Leaderboard::DEFAULT_OPTIONS
    options[:reverse] = true
    highscore_lb_online = Leaderboard.new('lb_online_' + mode,options)
    return highscore_lb_online.top(60)
  end

  # end online

end