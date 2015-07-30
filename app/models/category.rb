class Category < ActiveRecord::Base
    default_scope -> { order(name: :asc) }
    has_many :products, dependent: :destroy
    
    validates :name, presence: true , length: { maximum: 100 }, uniqueness: { case_sensitive: false }
end
