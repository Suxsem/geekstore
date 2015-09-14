require "business/orders_filter"

class OrdersFilterUser < OrdersFilter
    
    # retrieve all orders of the current user
    def filter
        @user = current_user
        @orders = @user.orders.paginate(page: params[:page])        
    end
end