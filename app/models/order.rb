# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Order < ApplicationRecord
  has_many :order_lines, dependent: :destroy, inverse_of: :order, autosave: true

  accepts_nested_attributes_for :order_lines, reject_if: :all_blank, allow_destroy: true
end
