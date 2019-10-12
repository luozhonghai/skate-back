class Api::SingleController < ApplicationController
  
  def update_user
    query = User.pluck(:device_id).index(params[:device_id])
    if query == nil
      @new_user = User.create(device_id: params[:device_id], user_name: params[:name], level: params[:level], score_single: params[:score])
      #binding.pry
      Leaderboards.insert_leaderboard_single(params[:device_id], params[:score])
      render json: { code: "1" }
    else
      @user = User.find_by(device_id: params[:device_id])
      Leaderboards.insert_leaderboard_single(params[:device_id], params[:score])
      @user.score_single = params[:score]
      @user.user_name = params[:name]
      @user.level = params[:level]
      @user.save!
      render json: { code: "1" }
    end
  end


end
