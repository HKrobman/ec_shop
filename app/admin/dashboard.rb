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

    columns do
      column do
        div do
          br
          text_node %{<iframe src="https://rpm.newrelic.com/public/charts/6VooNO2hKWB"
                              width="500" height="300" scrolling="no" frameborder="no">
                      </iframe>}.html_safe
        end
      end

    end
 end

    
=begin
ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
=end
end
