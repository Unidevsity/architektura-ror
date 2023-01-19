class AddLineTotalToOrderLine < ActiveRecord::Migration[7.0]
  def change
    add_column :order_lines, :line_total, :integer, default: 0
  end
end
