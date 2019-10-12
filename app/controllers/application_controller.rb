class ApplicationController < ActionController::API
  private

  def not_authorized
    render json: {error: 'Not authorized'}, status: :unauthorized
  end

end
