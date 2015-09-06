class OrdersFilter < ApplicationController
    def initialize (request)
        @_request = request
    end
    def filter
        raise NotImplementedError, 'This is an interface'
    end
end
