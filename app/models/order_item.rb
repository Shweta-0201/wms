class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :inventory
  
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than: 0 }
  validates :total_price, presence: true, numericality: { greater_than: 0 }
  
  before_validation :calculate_total_price
  
  private
  
  def calculate_total_price
    if quantity.present? && unit_price.present?
      self.total_price = quantity * unit_price
    end
  end
end
