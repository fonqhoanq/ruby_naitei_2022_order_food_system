class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :user_name
      t.string :address
      t.integer :status, default: 0
      t.float :total
      t.string :payment_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
