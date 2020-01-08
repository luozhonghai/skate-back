class Api::ChallengeController < Api::BaseController

  #device_id, target_device_id, score
  def send_request
    @target_user = User.find_by(device_id: params[:target_device_id])
    if @target_user == nil
      render json: {error: "not valid target user."}
      return
    end
    @target_user.challenge_request ||= {}.to_json
    hash_values = JSON.parse(@target_user.challenge_request)
    device_id = params[:device_id]
    hash_values[device_id] = params[:score]
    @target_user.challenge_request = hash_values.to_json
    @target_user.save!

    @user = User.find_by(device_id: params[:device_id])
    @user.try_challenge ||= 0
    @user.try_challenge += 1
    @user.save!
    render json: hash_values.to_json
  end

  #device_id
  def receive_request
    @user = User.find_by(device_id: params[:device_id])
    challenge_request = @user.challenge_request
    @user.challenge_request = {}.to_json
    @user.save!
    render json: challenge_request
  end

  #device_id challenge_result {target_device_id: -1}
  def send_result
    #@user = User.find_by(device_id: params[:device_id])
    hash_values = JSON.parse(params[:challenge_result])
    device_id = params[:device_id]
    hash_values.each do |k,v|
      @target_user = User.find_by(device_id: k)
      if @target_user == nil
        #render json: {error: " find not valid target user."}
        #return
        next
      end
      @target_user.challenge_result ||= {}.to_json
      hash_value = JSON.parse(@target_user.challenge_result)
      hash_value[device_id] = v
      @target_user.challenge_result = hash_values.to_json
      @target_user.save!
    end
    render json: { code: 1 }
  end

  #device_id
  def receive_result
    @user = User.find_by(device_id: params[:device_id])
    challenge_result = @user.challenge_result
    @user.challenge_result = {}.to_json
    @user.save!
    render json: challenge_result
  end

  #device_id win_count
  def win
    @user = User.find_by(device_id: params[:device_id])
    @user.win_challenge ||= 0
    @user.win_challenge += params[:win_count].to_i
    @user.save!

    b_20 = Leaderboards.insert_leaderboard_challenge(params[:device_id], @user.win_challenge)

    render json: { win: @user.win_challenge, refresh_top: b_20 }
  end


  def get_user
    hash_info = {}
    hash_info[:player_info] = {}
    device_id = params[:device_id]
    @user = User.find_by(device_id: params[:device_id])
    if @user != nil
      hash_info[:player_info] = {
          name: @user.nickname,
          try_challenge: @user.try_challenge,
          win_challenge: @user.win_challenge,
          rank_challenge: Leaderboards.get_rank_in_challenge(params[:device_id]),
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
    hash_info[:player_infos] = Leaderboards.get_top20_in_challenge

    hash_info[:player_infos].each do |info|
      user = User.find_by(device_id: info[:member])
      info[:name] = user != nil ?  user.nickname : ""
      info[:try_challenge] = user != nil ?  user.try_challenge : 0
      #info[:score] = user != nil ?  user.score_single : ""
    end

    render json: hash_info
  end

end
