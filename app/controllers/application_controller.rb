class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception     #CSRF対策
   before_action :configure_permitted_parameters, if: :devise_controller? 
   helper_method :current_cart 
  
  private 
  
  
  def current_cart
      @cart ||= Cart.find_or_create_by(user_id: current_user.id)
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name_kanji, :name_kanji])
    devise_parameter_sanitizer.permit(:update) do |user_params|
      user_params.permit(:name_kana, :name_kanji,:telphone, :zip_code, :prefecture, :city, :address1, :address2 , :email)
    end
  end


end
