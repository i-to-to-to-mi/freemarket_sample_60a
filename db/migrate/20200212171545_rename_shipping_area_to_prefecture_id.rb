class RenameShippingAreaToPrefectureId < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :shipping_area, :prefecture_id
    change_column :items, :prefecture_id, :integer
  end
end

