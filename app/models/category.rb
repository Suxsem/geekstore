class Category < ActiveRecord::Base

  # always sort categories alphabetically
  default_scope -> { order(name: :asc) }
  
  # declare one-to-many relationship between categories and products
  # =>  if a category is destroyed then delete all associated products
  has_many :products, dependent: :destroy
  
  # name must be present, must be unique and can't be longer then 100 chars
  validates :name, presence: true , length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  
end
