class RegistrationsController < Devise::RegistrationsController
    
    def after_sign_up_path_for(resource)
      user_path(resource)
    end
    
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end  

    
  private 
    def sign_up_params
      params.require(:user).permit(:name_kana, :name_kanji, :email, :password, :password_confirmation)
    end
      
    def account_update_params
      params.require(:user).permit(:name_kana, :name_kanji, :telphone, :zip_code, :prefecture, :city, :address1, :address2)
    end


end