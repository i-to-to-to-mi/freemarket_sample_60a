class RenameTwoColumnsToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :margin, :margin_price
    rename_column :items, :profit, :profit_price
  end
end
