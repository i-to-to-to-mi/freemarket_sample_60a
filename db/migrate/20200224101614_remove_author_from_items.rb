class RemoveAuthorFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :category, :VARCHA
    add_reference :items,:category,foreign_key: true
  end
end
