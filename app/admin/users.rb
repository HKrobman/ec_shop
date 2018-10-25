ActiveAdmin.register User do
  menu priority: 4
  config.batch_actions = true

  filter :name_kanji
  filter :email
  filter :created_at

  permit_params :name_kanji, :email, :password

  index do
    selectable_column
    id_column
    column :name_kanji
    column :email
    column :created_at
    column :telphone
    actions
  end

  show title: :name_kanji do
    panel "注文履歴" do
      table_for(user.orders) do
        column("Order", sortable: :id) do |order|
          link_to "##{order.id}", admin_order_path(order)
        end
        #column("State") { |order| status_tag(order.state) }
        column("Date", sortable: :created_at) do |order|
          pretty_format(order.created_at.strftime('%Y年%m月%d日 %H:%M:%S'))
        end
        column("Total") { |order| order.total_price }
      end
    end

    panel "住所" do
      table_for(user) do
        column("Fullname") do |a|
          a.name_kanji
         # link_to a.name_kanji.to_s,
          #        admin_user_user_address_path(user.id, a.id)
        end
        column :zip_code
        column :prefecture
        column :city
        column :address1
        column :address2
        
        #tr class: "action_items" do
          #td link_to("New Address", new_admin_user_user_address_path(user),
         #            class: :button)
        end
      end
    end
    #active_admin_comments
  


  form do |f|
    f.inputs do
      f.input :name_kanji
      f.input :password, input_html: { autocomplete: true }
      f.input :email
      f.input :zip_code
      f.input :prefecture
      f.input :city
      f.input :address1
      f.input :address2
    end
    f.actions
  end

  sidebar "Customer Details", only: :show do
    attributes_table_for user, :name_kanji, :email, :created_at
  end

  sidebar "Order History", only: :show do
    attributes_table_for user do
      #row("Total Orders") { user.orders.complete.count }  orderにactiveを追加,trueの数をカウント
      row("Total Value") do
        user.orders.sum(:total_price)  #user.orders.active.count
      end
    end
  end
end