require "business/visitor_price"

class Order < ActiveRecord::Base
  
  # declare one-to-many relationship between users and orders
  belongs_to :user
  
  # declare one-to-many relationship between products and orders
  belongs_to :product
  
  # declare many-to-many relationship between upgrades and orders
  has_and_belongs_to_many :upgrades
  
  # always sort orders alphabetically
  default_scope -> { order(created_at: :desc) }

  # user must be present
  validates :user, presence: true
  
  # product must be present
  validates :product, presence: true
  
  # status must be present and can't be longer then 100 chars
  validates :status, presence: true , length: { maximum: 100 }
  
  # price must be present
  validates :price, presence: true, numericality: { }
  
  # compute the order price before creating it
  before_validation :compute_price, on: :create

  # define possible status that an order can go through during its lifecycle
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

    # compute the order price to be paid
    def compute_price
      
      # set the initial state of an order
      self.status = Order.possible_status[:wait_payment]
      
      # use the visitor pattern to traverse the product and its upgrades
      visitor = VisitorPrice.new
      visitor.visit_product product
      upgrades.each do |upgrade|
        visitor.visit_upgrade upgrade
      end
      self.price = visitor.price
      
    end
  
end
