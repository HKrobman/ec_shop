ActiveAdmin.register Stock do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  index do
    column("商品名") {|stock| stock.product.name }
    column("商品ID") {|stock| stock.product.id }
    column("商品在庫"){|stock| stock.quantity }
    column("販売在庫"){|stock| stock.sales_quantity }
    column("入荷予定日"){|stock| stock.arriving_on }
    column("コメント"){|stock| stock.comment }
  end
  
   form do |f|
    f.inputs do
      f.input :product_id,
                 label: '商品名',
                 as: :select,
                 collection: Product.all.map { |a| [a.name, a.id] }
      f.input :quantity
      f.input :sales_quantity
      f.input :arriving_on
      f.input :comment
    end
    f.actions
  end
  
  
  show do
  attributes_table do
    row '在庫数' do
      resource.quantity
    end
    row '商品名' do
      resource.product
    end
    row '販売数' do
      resource.sales_quantity
    end
    row '入荷予定日' do
      resource.arriving_on
    end
    row 'コメント' do
      resource.comment
    end
  end
  end
  
  
  controller do
    def permitted_params
      params.permit stock: [:quantity,:product_id,:sales_quantity,:comment]
    end
  end
  
end


