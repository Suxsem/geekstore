class User < ActiveRecord::Base
  
  # declare one-to-many relationship between users and orders
  # =>  if a user is destroyed then delete all associated orders
  has_many :orders, dependent: :destroy
  
  # convert username to downcase before creating a new user
  before_save { self.name = name.downcase }
  
  # always sort users alphabetically; admins before non-admins
  default_scope -> { order(admin: :desc, name: :asc) }
  
  # name must be present, must be unique and can't be longer then 50 chars
  validates :name, presence: true , length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  
  # store a digest of the user password
  has_secure_password
  
  # password must have more then 6 chars
  validates :password, length: { minimum: 6 }, allow_nil: true
end
