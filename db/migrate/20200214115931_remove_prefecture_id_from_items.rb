class RemovePrefectureIdFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :prefecture_id, :integer
    add_column :items, :prefectures, :string
    
  end
end
