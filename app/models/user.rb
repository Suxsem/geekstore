class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  
  before_save { self.name = name.downcase }
  default_scope -> { order(admin: :desc, name: :asc) }
  
  validates :name, presence: true , length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true
end
