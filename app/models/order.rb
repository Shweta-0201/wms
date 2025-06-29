class Order < ApplicationRecord
  validates :order_number, presence: true, uniqueness: true
  validates :customer_name, presence: true
  validates :customer_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :status, presence: true, inclusion: { in: %w[pending processing shipped delivered cancelled] }
  validates :total_amount, presence: true, numericality: { greater_than: 0 }
  validates :order_date, presence: true
  
  has_many :order_items, dependent: :destroy
  has_many :inventories, through: :order_items
  
  before_validation :generate_order_number, on: :create
  before_validation :set_order_date, on: :create
  
  private
  
  def generate_order_number
    self.order_number ||= "WMS-#{Time.current.strftime('%Y%m%d')}-#{SecureRandom.hex(4).upcase}"
  end
  
  def set_order_date
    self.order_date ||= Time.current
  end
end
