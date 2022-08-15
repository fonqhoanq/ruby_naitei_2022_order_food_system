class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :address
      t.string :phone_number
      t.boolean :activated, default: false
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
