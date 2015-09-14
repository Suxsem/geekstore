class Product < ActiveRecord::Base
  
  # declare one-to-many relationship between categories and products
  belongs_to :category

  # declare many-to-many relationship between stores and products
  has_and_belongs_to_many :stores
  
  # declare one-to-many relationship between products and upgrades
  # =>  if a product is destroyed then delete all associated upgrades
  has_many :upgrades, dependent: :destroy
  
  # declare one-to-many relationship between products and orders
  # =>  if a product is destroyed then delete all associated orders
  has_many :orders, dependent: :destroy
  
  # associate an ImageUploader object to the current product to display the product image
  mount_uploader :image, ImageUploader
  
  # name must be present, must be unique and can't be longer then 100 chars
  validates :name, presence: true , length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  
  # category must be present
  validates :category, presence: true
  
  # price must be present and must be an integer number between 0 and 100
  validates :discount, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  
  # price must be present and must be a number
  validates :price, presence: true, numericality: { }
  
  # validate product image size
  validate  :image_size
  
  # compute the final price of this product
  def final_price
    price * (100 - discount) / 100
  end
  
  private

    # Validates the size of an uploaded picture.
    def image_size
      if image.size > 5.megabytes
        errors.add(:picture, "l'immagine non deve superare 5MB")
      end
    end  
  
end
