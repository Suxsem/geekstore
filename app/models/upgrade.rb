class Upgrade < ActiveRecord::Base
  belongs_to :product
  has_and_belongs_to_many :orders
  before_destroy :destroy_orders
  
  validates :name, presence: true , length: { maximum: 100 }, uniqueness: { scope: :product, case_sensitive: false }
  validates :product, presence: true
  validates :price, presence: true, numericality: { }

  def name_with_price
    "#{name} (+#{price}€)"
  end
  
  private
  
    def destroy_orders
      orders.each do |order|
          order.destroy
      end
      orders.destroy
    end
  
end
