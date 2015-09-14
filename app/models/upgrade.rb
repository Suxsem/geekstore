class Upgrade < ActiveRecord::Base
  
  # declare one-to-many relationship between products and upgrades
  belongs_to :product
  
  # declare many-to-many relationship between upgrades and orders
  has_and_belongs_to_many :orders
  
  # if an upgrade is destroyed then delete all associated orders
  before_destroy :destroy_orders
  
  # name must be present, must be unique and can't be longer then 100 chars
  validates :name, presence: true , length: { maximum: 100 }, uniqueness: { scope: :product, case_sensitive: false }
  
  # product must be present
  validates :product, presence: true
  
  # price must be present and must be a number
  validates :price, presence: true, numericality: { }

  # return the current upgrade as "upgrade_name (+upgrade_price€)"
  def name_with_price
    "#{name} (+#{price}€)"
  end
  
  private
  
    # desotry all orders associated with the selected upgrade
    def destroy_orders
      orders.each do |order|
          order.destroy
      end
      orders.destroy
    end
  
end
