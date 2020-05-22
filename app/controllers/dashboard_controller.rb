class DashboardController < ManagerController
  before_action :authenticate_account!
  layout 'dashboard'

  def show

  end

  def search

  end

  def search_result
    search_device_id = params[:search_user][:device_id]
    user = User.find_by(device_id: search_device_id)
    redirect_to user_path(user)
  end

end