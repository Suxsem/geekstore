class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  
  before_save { self.name = name.downcase }
  default_scope -> { order(admin: :desc, name: :asc) }
  
  validates :name, presence: true , length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true
    
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end    
end
