class DropTableCards < ActiveRecord::Migration[5.2]
  def change
    drop_table :cards do |t|
      t.integer :user_id, null: false
      t.string :customer_id, null: false
      t.string :card_id, ull: false

      t.timestamps
    end
  end
end

