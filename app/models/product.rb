class Product < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :stores
  has_many :upgrades, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  mount_uploader :image, ImageUploader
  
  validates :name, presence: true , length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :category, presence: true
  validates :discount, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  validates :price, presence: true, numericality: { }
  validate  :image_size
  
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
