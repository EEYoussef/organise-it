class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :project, null: false, foreign_key: true
      t.string :payment_id
      t.string :receipt_url
      t.references :freelanceruser, null: false, foreign_key: {to_table: :users}
      t.references :user, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
