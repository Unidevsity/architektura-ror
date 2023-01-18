class CreateOrderLine < ActiveRecord::Migration[7.0]
  def change
    create_table :order_lines do |t|
      t.belongs_to :order
      t.belongs_to :product
      t.integer :quantity
      t.timestamps
    end
  end
end
