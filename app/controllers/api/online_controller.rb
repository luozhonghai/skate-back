class Api::OnlineController < Api::BaseController
  #device_id, name, map_id, score
  def update_user
    query = User.pluck(:device_id).index(params[:device_id])
    if query == nil
      @new_user = User.new(device_id: params[:device_id], nickname: params[:name])
      #binding.pry
      mode = params[:map_id].to_i
      if mode == 0
        @new_user.score_0_online = params[:score]
      elsif mode == 1
        @new_user.score_1_online = params[:score]
      elsif mode == 2
        @new_user.score_2_online = params[:score]
      else
        render json: { error: "not valid map id" }
        return
      end
      @new_user.save!
      b_20 = Leaderboards.insert_leaderboard_online(params[:device_id], params[:score], mode.to_s)

      render json: { code: "1", info: "create user", refresh_top: b_20}
    else
      @user = User.find_by(device_id: params[:device_id])
      @user.nickname = params[:name]
      mode = params[:map_id].to_i
      if mode == 0
        @user.score_0_online = params[:score]
      elsif mode == 1
        @user.score_1_online = params[:score]
      elsif mode == 2
        @user.score_2_online = params[:score]
      else
        render json: { error: "not valid map id" }
        return
      end
      @user.save!

      b_20 = Leaderboards.insert_leaderboard_online(params[:device_id], params[:score], mode.to_s)

      render json: { code: "1", info: "update user", refresh_top: b_20 }
    end

  end



  def get_user
    hash_info = {}
    hash_info[:player_info] = {}
    device_id = params[:device_id]
    @user = User.find_by(device_id: params[:device_id])
    if @user != nil
      rank_0 = Leaderboards.get_rank_in_online(params[:device_id], 0)
      rank_1 = Leaderboards.get_rank_in_online(params[:device_id], 1)
      rank_2 = Leaderboards.get_rank_in_online(params[:device_id], 2)

      hash_info[:player_info] = {
          name: @user.nickname,
          score_0_online: @user.score_0_online,
          rank_0_online: rank_0 == nil ? -1 : rank_0,
          score_1_online: @user.score_1_online,
          rank_1_online: rank_1 == nil ? -1 : rank_1,
          score_2_online: @user.score_2_online,
          rank_2_online: rank_2 == nil ? -1 : rank_2,
      }
    end
    #if device_id[0..7] == "glasses3"
    #    hash_info[:player_info] = {
    #      error: "illegal login",
    #    }
    #end
    render json: hash_info
  end

  # map_id
  def toplist
    hash_info = {}
    [0, 1 , 2].each do |i|
      key = "player_infos_#{i}"
      hash_info[key] = []
      hash_info[key] = Leaderboards.get_top20_in_online(i)

      hash_info[key].each do |info|
        user = User.find_by(device_id: info[:member])
        info[:name] = user != nil ?  user.nickname : ""
        info[:score] = user != nil ?  [user.score_0_online, user.score_1_online, user.score_2_online][i] : ""
        #info[:score] = user != nil ?  user.score_single : ""
      end
    end

    render json: hash_info
  end


end
