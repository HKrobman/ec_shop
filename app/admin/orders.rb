ActiveAdmin.register Order do
  menu :priority => 3
  actions :index, :show

  filter :total_price
  filter :checked_out_at

  #scope :all, :default => true
  #scope :in_progress
  #scope :complete

  index do
    column("注文番号", :sortable => :id) {|order| link_to "##{order.id} ", admin_order_path(order) }
    #column("State")                   {|order| status_tag(order.state) }
    column("注文日", :checked_out_at){|order| order.created_at.strftime('%Y年%m月%d日 %H:%M:%S') }
    column("購入者", :user, :sortable => :user_id){|order| order.addressee_name_kanji}
    column("支払い方法"){|order| order.pay_type}
    column("合計金額")                   {|order| order.total_price }
    column("郵便番号"){|order| order.addressee_zip_code}
    column("都道府県"){|order| order.addressee_prefecture}
    column("市町村区"){|order| order.addressee_city}
    column("住所1"){|order| order.addressee_address1}
    column("住所2"){|order| order.addressee_address2}
    column("電話番号"){|order| order.order_telphone}
  end

  show do
    panel "注文詳細" do
      table_for(order.cart_items) do |t|
        t.column("商品名") {|item| auto_link item.product        }
        t.column("注文個数")   {|item|  item.quantity }
        t.column("商品価格")   {|item|  item.product.sale_price }
        t.column("支払いタイプ") {order.pay_type}
        tr :class => "odd" do
          td ""
          td "注文価格:", :style => "text-align: right;"
          td order.total_price
          td "送料:350円   <支払いタイプが現金なら手数料400円加算>"
        end
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
