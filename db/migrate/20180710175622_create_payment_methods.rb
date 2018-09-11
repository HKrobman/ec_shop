class CreatePaymentMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.string :payment_method
      t.string :card_number
      t.string :security_code
      t.date :period

      t.timestamps
    end
  end
end
