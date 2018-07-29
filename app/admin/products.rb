ActiveAdmin.register Product do
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
  
  filter :category_id,
                 label: 'カテゴリー',
                 as: :select,
                 collection: Category.all.map { |a| [a.category_name, a.id] }
  filter :name
  filter :company
  filter :code
  filter :sale_price
  filter :color
  filter :delivery_days
  filter :active
  filter :created_at
  filter :updated_at
  

  index do
      column :name
      column :category_id
      column :company
      column :released_on
      column :code
      column :list_price
      column :sale_price
      column :description
      column :image_url
      column :color
      column :delivery_days
      column :active
  end
  
   form do |f|
    f.inputs do
      f.input :name
      f.input :category_id,
                 label: 'カテゴリー',
                 as: :select,
                 collection: Category.all.map { |a| [a.category_name, a.id] }
      f.input :company
      f.input :released_on
      f.input :code
      f.input :list_price
      f.input :sale_price
      f.input :description
      f.input :image_url
      f.input :delivery_days
      f.input :color
      f.input :active
    end
    f.actions
  end
  
  
  show do
  attributes_table do
    row '商品名' do
      resource.name
    end
    row 'カテゴリー' do
      resource.category
    end
    row '会社名' do
      resource.company
    end
    row '発売日' do
      resource.released_on
    end
    row '商品コード' do
      resource.code
    end
    row '定価' do
      resource.list_price
    end
    row '実売価格' do
      resource.sale_price
    end
    row '商品説明' do
      resource.description
    end
    row '商品画像' do
      resource.image_url
    end
    row '配達日数' do
      resource.delivery_days
    end
    row 'カラー' do
      resource.color
    end
    row '状態' do
      resource.active
    end
  end
  end
  
  
  controller do
    def permitted_params
      params.permit product: [:name,:category,:category_id,:company,:released_on,:code,:list_price,:sale_price,:description,:image_url,:delivery_days,:active,:color]
    end
  end
  
end
