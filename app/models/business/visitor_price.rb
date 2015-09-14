require "business/visitor"

class VisitorPrice < Visitor
    
    # generate getter and setter for price attribute
    attr_accessor :price
    
    # set price to zero during oject creation
    def initialize
        @price = 0
    end
    
    # add the product price to the total price
    def visit_product product
        @price += product.final_price
    end
    
    # add the upgrade price to the total price
    def visit_upgrade upgrade
        @price += upgrade.price
    end
end