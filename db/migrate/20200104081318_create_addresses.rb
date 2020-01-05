class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :postal_code, null: false
      t.string :Prefectures, null: false
      t.string :city, null: false
      t.string :address1, null: false
      t.string :address2
      t.integer :address_phone_number, null: false

      t.timestamps
    end
  end
end
