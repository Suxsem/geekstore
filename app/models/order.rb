class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  has_and_belongs_to_many :upgrades
  
  default_scope -> { order(created_at: :desc) }

  validates :user, presence: true
  validates :product, presence: true
  validates :status, presence: true , length: { maximum: 100 }
  validates :price, presence: true, numericality: { }
    
  before_validation :compute_price, on: :create

  private

    # Converts email to all lower-case.
    def compute_price
      self.status = "in attesa di pagamento"
      price = product.final_price
      upgrades.each do |upgrade|
        price += upgrade.price
      end
      self.price = price
    end
  
end
