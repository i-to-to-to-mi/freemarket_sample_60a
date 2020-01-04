class ChangeDatatypePrefecturesOfAddresses < ActiveRecord::Migration[5.2]
  def change
    change_column :addresses, :Prefectures, :integer
  end
end
