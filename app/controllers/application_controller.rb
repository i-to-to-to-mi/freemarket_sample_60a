class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_category


  
  protected
  def set_category
    @parents = Category.all.order("id ASC").limit(13)
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :nickname,
      :first_name, :first_name_kana, 
      :last_name, :last_name_kana, 
      :birth_year, :birth_month, :birth_day, 
      :introduction, 
      :avatar])
  end
  
  def after_sign_in_path_for(resource) 
    root_path
  end


  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
