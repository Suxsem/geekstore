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

  def self.possible_status
    {
      wait_payment: "in attesa di pagamento",
      wait_confirm: "in attesa di conferma",
      denied: "ordine negato",
      supplying: "in approvvigionamento",
      packing: "in preparazione alla spedizione",
      sent: "spedito"
    }
  end
  
  private

    # Converts email to all lower-case.
    def compute_price
      self.status = Order.possible_status[:wait_payment]
      price = product.final_price
      upgrades.each do |upgrade|
        price += upgrade.price
      end
      self.price = price
    end
  
end
