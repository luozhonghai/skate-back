class DashboardController < ManagerController
  before_action :authenticate_account!
  layout 'dashboard'

  def show

  end
end