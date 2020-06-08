class Api::SingleMapController < ApplicationController
  def is_user_unique
    @user = User.find_by(nickname: params[:name])
    if @user == nil
      render json: { unique: "1"}
    else
      render json: { unique: "0"}
    end
  end

  def get_score_rank
    rank_score = Leaderboards.get_score_rank_in_single_map(params[:score], params[:map_id]) + 1
    render json: { rank: rank_score}
  end

  def update_user
    query = User.pluck(:device_id).index(params[:device_id])
    if query == nil

      @new_user = User.create(device_id: params[:device_id], nickname: params[:name])
      #binding.pry

      mode = params[:map_id].to_i
      if mode == 0
        @new_user.level_0 = params[:level]
        @new_user.score_single_0 = params[:score]
      elsif mode == 1
        @new_user.level_1 = params[:level]
        @new_user.score_single_1 = params[:score]
      elsif mode == 2
        @new_user.level_2 = params[:level]
        @new_user.score_single_2 = params[:score]
      else
        render json: { error: "not valid map id" }
        return
      end

      b_60 = Leaderboards.insert_leaderboard_single_map(params[:device_id], params[:score], mode.to_s)
      rank_self = Leaderboards.get_rank_in_single_map(params[:device_id], mode.to_s)
      render json: { code: "1", info: "create user", refresh_top: b_60, rank: rank_self}
    else
      @user = User.find_by(device_id: params[:device_id])
      mode = params[:map_id].to_i
      if mode == 0
        @new_user.level_0 = params[:level]
        @new_user.score_single_0 = params[:score]
      elsif mode == 1
        @new_user.level_1 = params[:level]
        @new_user.score_single_1 = params[:score]
      elsif mode == 2
        @new_user.level_2 = params[:level]
        @new_user.score_single_2 = params[:score]
      else
        render json: { error: "not valid map id" }
        return
      end
      @user.nickname = params[:name]
      @user.save!
      b_60 = Leaderboards.insert_leaderboard_single_map(params[:device_id], params[:score], mode.to_s)
      rank_self = Leaderboards.get_rank_in_single_map(params[:device_id], mode.tp_s)
      render json: { code: "1", info: "update user", refresh_top: b_60, rank: rank_self }
    end
  end
  end

  def get_user
    hash_info = {}
    hash_info[:player_info] = {}
    device_id = params[:device_id]
    @user = User.find_by(device_id: params[:device_id])
    if @user != nil
      hash_info[:player_info] = {
          name: @user.nickname,
          level_0: @user.level_0,
          level_1: @user.level_1,
          level_2: @user.level_2,
          score_single_0: @user.score_single_0,
          rank_single_0: Leaderboards.get_rank_in_single_map(params[:device_id], 0),
          score_single_1: @user.score_single_1,
          rank_single_1: Leaderboards.get_rank_in_single_map(params[:device_id], 1),
          score_single_2: @user.score_single_2,
          rank_single_2: Leaderboards.get_rank_in_single_map(params[:device_id], 2),
      }
  end

  def toplist
    hash_info = {}
    [0, 1 , 2].each do |i|
      key = "player_infos_#{i}"
      hash_info[key] = []
      hash_info[key] = Leaderboards.get_top60_in_single_map(i)

      hash_info[key].each do |info|
        user = User.find_by(device_id: info[:member])
        info[:name] = user != nil ?  user.nickname : ""
        info[:score] = user != nil ?  [user.level_0, user.level_1, user.level_2][i] : ""
        #info[:score] = user != nil ?  user.score_single : ""
      end
    end

    render json: hash_info
  end
end
