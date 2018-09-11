class ContactMailer < ActionMailer::Base
  default from: "管理者",
      reply_to: "nldektar@gmail.com" 

  def sent(contact)
    @contact = contact
    [@contact.email, "nldektar@gmail.com"].each do |email|
      mail(to: @contact.email, subject: "Thank you for your contact!")
    end
  end
end