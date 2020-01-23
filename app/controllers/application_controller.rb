# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
  
  def configure_permitted_parameters
    # 新規登録時
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :accepted])
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:profile])
    
    #編集時
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile])
    # devise_parameter_sanitizer.permit(:account_update, keys: [:profile])
  end
  
  def set_search
    @search = Post.ransack(params[:q])
    @search_posts = @search.result
  end
end
