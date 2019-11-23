require 'leaderboard'
require 'json'
class Leaderboards
  def initialize(args)

  end

  #begin single
  def self.insert_leaderboard_single(identifier, score)
    highscore_lb_single = Leaderboard.new('lb_single')
    member_60 = highscore_lb_single.member_at(20)
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
    return highscore_lb_single.top(20)
  end

  # end single
  #

  # begin online
  def self.insert_leaderboard_online(identifier, score, mode)
    #options = Leaderboard::DEFAULT_OPTIONS.clone
    options = {}
    options[:reverse] = true
    highscore_lb_online = Leaderboard.new('lb_online_' + mode.to_s, options)
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
    options = {}
    options[:reverse] = true
    highscore_lb_online = Leaderboard.new('lb_online_' + mode.to_s,options)
    return highscore_lb_online.rank_for(identifier)
  end

  def self.get_top20_in_online(mode)
    options = {}
    options[:reverse] = true
    highscore_lb_online = Leaderboard.new('lb_online_' + mode.to_s,options)
    return highscore_lb_online.top(20)
  end

  # end online
  #
  #

  #begin challenge
  def self.insert_leaderboard_challenge(identifier, score)
    highscore_lb_challenge = Leaderboard.new('lb_challenge')
    member_20 = highscore_lb_challenge.member_at(20)
    rank_me = highscore_lb_challenge.rank_for(identifier)
    if rank_me == nil || member_20 == nil || member_20[:score] == nil || member_20[:score].to_i < score.to_i
      highscore_lb_challenge.rank_member(identifier, score)
      return true
    end

    return false
    #else ignore
  end

  def self.get_rank_in_challenge(identifier)
    highscore_lb_challenge = Leaderboard.new('lb_challenge')
    return highscore_lb_challenge.rank_for(identifier)
  end

  def self.get_top20_in_challenge()
    highscore_lb_challenge = Leaderboard.new('lb_challenge')
    return highscore_lb_challenge.top(20)
  end
  #end challenge
  #
  #
  #

  def self.task_rank_leaderboards
    member_data = []
    users = User.all
    users.each do |user|
      member_data << user.device_id
      member_data << user.score_single
    end
    #bulk rank datas
    highscore_lb_single = Leaderboard.new('lb_single')
    highscore_lb_single.rank_members(member_data)

    options = {}
    options[:reverse] = true
    member_data = []
    users.each do |user|
      member_data << user.device_id
      member_data << user.score_0_online
    end
    highscore_lb_online = Leaderboard.new('lb_online_0', options)
    highscore_lb_online.rank_members(member_data)

    member_data = []
    users.each do |user|
      member_data << user.device_id
      member_data << user.score_1_online
    end
    highscore_lb_online = Leaderboard.new('lb_online_1', options)
    highscore_lb_online.rank_members(member_data)

    member_data = []
    users.each do |user|
      member_data << user.device_id
      member_data << user.score_2_online
    end
    highscore_lb_online = Leaderboard.new('lb_online_2', options)
    highscore_lb_online.rank_members(member_data)

    member_data = []
    users.each do |user|
      member_data << user.device_id
      member_data << user.win_challenge
    end
    highscore_lb_challenge = Leaderboard.new('lb_challenge')
    highscore_lb_challenge.rank_members(member_data)

  end
end