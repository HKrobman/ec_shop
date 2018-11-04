class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
    @user = current_user
    @contact.name = @user.name_kanji
    @contact.telphone = @user.telphone
    @contact.email = @user.email
  end
  
  def create
    binding.pry
    @contact = Contact.new(
      user_id: params[:user_id],
      name: contact_params[:name],
      telphone: contact_params[:telphone],
      email: contact_params[:email],
      content_type: contact_params[:content_type],
      content: contact_params[:content]
      )
      
    if @contact.save
      render :accepted
    else
      flash[:alert] = "入力内容をお確かめください"
    end

  end

  private

    def contact_params
      params.require(:contact).permit(:name, :telphone, :email, :content_type, :content, :user_id)
    end

end