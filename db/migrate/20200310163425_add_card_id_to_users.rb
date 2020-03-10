class AddCardIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :card, index: true
  end
end
