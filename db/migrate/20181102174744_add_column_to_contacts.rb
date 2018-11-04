class AddColumnToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :user_id, :integer
    add_column :contacts, :status, :boolean, default: false, null: false
  end
end
