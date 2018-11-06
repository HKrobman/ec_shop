ActiveAdmin.register Order do
  menu :priority => 3
  #actions :index, :show, :edit
  permit_params :status

  filter :total_price
  filter :checked_out_at

  #scope :all, :default => true
  #scope :in_progress
  #scope :complete
   form do |f|
    f.inputs do
      f.input :addressee_name_kana
      f.input :addressee_name_kanji
      f.input :addressee_zip_code
      f.input :order_telphone
      f.input :addressee_prefecture
      f.input :addressee_city
      f.input :addressee_address1
      f.input :addressee_address2
      f.input :pay_type
      f.input :total_price
      f.input :delivery_date
      f.input :status
    end
    f.actions
  end

  index do
    column("注文番号", :sortable => :id) {|order| link_to "#{order.id} ", admin_order_path(order) }
    column("注文日", :checked_out_at){|order| order.created_at.strftime('%Y年%m月%d日 %H:%M:%S') }
    #column("配達予定日",:checked_out_at){|order| order.delivery_date.strftime('%Y年%m月%d日 %H:%M:%S') } 
    column("購入者", :user, :sortable => :user_id){|order| order.addressee_name_kanji}
    column("支払い方法"){|order| order.pay_type}
    column("合計金額")                   {|order| order.total_price }
    column("郵便番号"){|order| order.addressee_zip_code}
    column("都道府県"){|order| order.addressee_prefecture}
    column("市町村区"){|order| order.addressee_city}
    column("住所1"){|order| order.addressee_address1}
    column("住所2"){|order| order.addressee_address2}
    column("電話番号"){|order| order.order_telphone}
    column("発送状況"){|order| order.status ? "発送済み" : "未発送" }
  end
  


  show do
    panel "注文詳細" do
      table_for(order.cart_items) do |t|
        t.column("商品名") {|item| auto_link item.product        }
        t.column("注文個数")   {|item|  item.quantity }
        t.column("商品価格")   {|item|  item.product.sale_price }
        tr :class => "odd" do
        t.column("注文価格") {order.total_price}
          td ""
          td ""
          td ""
          if order.pay_type == "現金"
            td "(内訳: <商品合計> + <送料350円> + <手数料400円> )"
          else
            td "(内訳: <商品合計> + <送料:350円> )"
          end
          t.column("支払いタイプ") {order.pay_type}
        end
      end
      table_for(order.cart_items) do |t|
        t.column("配達予定日",:checked_out_at){order.delivery_date.strftime('%Y年%m月%d日 %H:%M:%S') } 
        t.column("郵便番号"){ order.addressee_zip_code }
        t.column("都道府県"){ order.addressee_prefecture }
        t.column("市町村区"){ order.addressee_city }
        t.column("住所1"){ order.addressee_address1 }
        t.column("その他住所"){ order.addressee_address2 }
        t.column("電話番号"){ order.order_telphone }
      end
    end
  end

  sidebar :customer_information, :only => :show do
    attributes_table_for order.user do
      row("User") { auto_link order.user.name_kanji }
      row :email
    end
  end

end
