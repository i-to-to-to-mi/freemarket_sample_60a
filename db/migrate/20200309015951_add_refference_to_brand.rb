class AddRefferenceToBrand < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :brand, index: true
  end
end
