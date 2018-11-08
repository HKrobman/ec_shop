ActiveAdmin.register_page "Dashboard" do
  menu priority: 1
  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Orders" do
          table_for Order.order("id desc").limit(10) do
            #column("State") { |order| status_tag(order.state) }
            column("Customer") { |order| link_to(order.user.email, user_path(order.user)) }
            column("Total")   { |order| order.total_price }
          end
        end
      end

      column do
        panel "Recent Customers" do
          table_for User.order("id desc").limit(10).each do |_user|
            column(:email)    { |user| link_to(user.email, user_path(user)) }
          end
        end
      end
    end # columns
 end
end
