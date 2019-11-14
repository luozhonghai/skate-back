class Api::BaseController < ActionController::API
  #protect_from_forgery with: :null_session
  private
  def not_authorized
    render json: {error: 'Not authorized'}, status: :unauthorized
  end

end
