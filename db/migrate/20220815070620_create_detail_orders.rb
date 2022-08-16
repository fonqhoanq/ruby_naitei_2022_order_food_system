class CreateDetailOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :detail_orders do |t|
      t.float :price
      t.integer :quantity
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
