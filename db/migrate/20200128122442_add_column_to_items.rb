class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :description, :string, null: false
    add_column :items, :condition, :string, null: false
    add_column :items, :cover_postage, :string, null: false
    add_column :items, :shipping_area, :integer, null: false
    add_column :items, :shipping_date, :string, null: false
    add_column :items, :price, :integer, null: false
    add_column :items, :margin, :integer, null: false
    add_column :items, :profit, :integer, null: false
    add_column :items, :category_id, :integer, null: false, foreign_key: true
    add_column :items, :brand_id, :integer, null: false, foreign_key: true, index: true
    add_column :items, :seller_id, :integer, null: false, foreign_key: true
    add_column :items, :buyer_id, :integer, foreign_key: true 
  end
end
