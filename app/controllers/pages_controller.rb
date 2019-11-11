class PagesController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :masquerade_account!
  # def home
  #   #render json: "aa"
  # end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

end
