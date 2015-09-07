class Visitor
    attr_accessor :price
    def visit_product
        raise NotImplementedError, 'This is an interface'
    end
    def visit_upgrade
        raise NotImplementedError, 'This is an interface'
    end
end