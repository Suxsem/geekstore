class Visitor
    
    # generate getter and setter for price attribute
    attr_accessor :price

    # declare the product visitor signature
    def visit_product
        raise NotImplementedError, 'This is an interface'
    end
    
    # declare the upgrade visitor signature    
    def visit_upgrade
        raise NotImplementedError, 'This is an interface'
    end
end