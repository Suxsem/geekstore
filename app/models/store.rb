class Store < ActiveRecord::Base
    
  # declare many-to-many relationship between stores and products
  has_and_belongs_to_many :products
  
end
