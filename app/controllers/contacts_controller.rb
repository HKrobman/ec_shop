class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
    @user = current_user
    @contact.name = @user.name_kanji
    @contact.telphone = @user.telphone
    @contact.email = @user.email
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      #ContactMailer.sent(@contact).deliver
      flash[:success] = "ありがとうございました。"
      render :accepted
    else
      flash[:alert] = "エラーが発生しました。"
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :telphone, :email, :content_type, :content, :user_id )
    end

end
