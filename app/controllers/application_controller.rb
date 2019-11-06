class ApplicationController < ActionController::Base
  private

  def not_authorized
    render json: {error: 'Not authorized'}, status: :unauthorized
  end

end
