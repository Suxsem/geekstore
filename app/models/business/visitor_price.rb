require "business/visitor"

class VisitorPrice < Visitor
    attr_accessor :price
    def initialize
        @price = 0
    end
    def visit_product product
        @price += product.final_price
    end
    def visit_upgrade upgrade
        @price += upgrade.price
    end
end