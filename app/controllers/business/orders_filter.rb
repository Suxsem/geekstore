class OrdersFilter < ApplicationController
    
    # initialize the oject storing the initial request
    def initialize (request)
        @_request = request
    end
    
    # declare the filter method signature
    def filter
        raise NotImplementedError, 'This is an interface'
    end
end
