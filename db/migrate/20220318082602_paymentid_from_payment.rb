class PaymentidFromPayment < ActiveRecord::Migration[6.1]
  def change
    remove_column :payments, :payment_id
  end
end
