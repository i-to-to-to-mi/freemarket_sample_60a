class AddColumsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :description, :text, null: false 
    add_column :items, :category, :string, null: false 
    add_column :items, :condition, :string, null: false 
    add_column :items, :cover_postage, :string, null: false 
    add_column :items, :shipping_area, :integer, null: false
    add_column :items, :shipping_date, :string, null: false 
    add_column :items, :price, :integer, null: false 
    add_column :items, :profit, :integer, null: false
    add_column :items, :margin, :integer, null: false  
    add_column :items, :brand, :string
    add_reference :items, :seller, null: false, foreign_key: { to_table: :users }
    add_reference :items, :buyer, foreign_key: { to_table: :users }
  end
end
