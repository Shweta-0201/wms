class Inventory < ApplicationRecord
  validates :sku, presence: true, uniqueness: true
  validates :name, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :location, presence: true
  
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
end
