ActiveAdmin.register Contact do


  index do
    column("氏名") {|contact| link_to "#{contact.name}", admin_contact_path(contact) }
    column("メールアドレス") {|contact| contact.email }
    column("電話番号") {|contact| contact.telphone }
    column("問い合わせ内容") {|contact| contact.content_type }
    column("お問い合わせ日", :checked_out_at){|contact| contact.created_at.strftime('%Y年%m月%d日 %H:%M:%S') }
  end
 
  show do
    attributes_table_for resource do
    
    row '氏名' do
      resource.name
    end
    row 'メールアドレス' do
      resource.email
    end
    row '電話番号' do
      resource.telphone
    end
    row '問い合わせ内容' do
      resource.content_type
    end
    row '本文' do
      resource.content
    end
    
    end
  end

end

