class Api::SingleController < Api::BaseController


  def is_user_unique
    @user = User.find_by(nickname: params[:name])
    if @user == nil
      render json: { unique: "1"}
    else
      render json: { unique: "0"}
    end
  end

  def get_score_rank
    rank_score = Leaderboards.get_score_rank_in_single(params[:score]) + 1
    render json: { rank: rank_score}
  end

  #device_id name level score
  def update_user
    query = User.pluck(:device_id).index(params[:device_id])
    if query == nil
      @new_user = User.create(device_id: params[:device_id], nickname: params[:name], level: params[:level], score_single: params[:score])
      #binding.pry
      b_60 = Leaderboards.insert_leaderboard_single(params[:device_id], params[:score])
      rank_self = Leaderboards.get_rank_in_single(params[:device_id])
      render json: { code: "1", info: "create user", refresh_top: b_60, rank: rank_self}
    else
      @user = User.find_by(device_id: params[:device_id])
      @user.score_single = params[:score]
      @user.nickname = params[:name]
      @user.level = params[:level]
      @user.save!
      b_60 = Leaderboards.insert_leaderboard_single(params[:device_id], params[:score])
      rank_self = Leaderboards.get_rank_in_single(params[:device_id])
      render json: { code: "1", info: "update user", refresh_top: b_60, rank: rank_self }
    end
  end

  #device_id
  def get_user
    hash_info = {}
    hash_info[:player_info] = {}
    device_id = params[:device_id]
    @user = User.find_by(device_id: params[:device_id])
    if @user != nil
      hash_info[:player_info] = {
          name: @user.nickname,
          level: @user.level,
          score_single: @user.score_single,
          rank_single: Leaderboards.get_rank_in_single(params[:device_id]),
      }
    end
    #if device_id[0..7] == "glasses3"
    #    hash_info[:player_info] = {
    #      error: "illegal login",
    #    }
    #end
    render json: hash_info
  end

  def toplist
    hash_info = {}
    hash_info[:player_infos] = []
    hash_info[:player_infos] = Leaderboards.get_top60_in_single

    hash_info[:player_infos].each do |info|
      user = User.find_by(device_id: info[:member])
      info[:name] = user != nil ?  user.nickname : ""
      info[:level] = user != nil ?  user.level : ""
      #info[:score] = user != nil ?  user.score_single : ""
    end

    render json: hash_info
  end



end
