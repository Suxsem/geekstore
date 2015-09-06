require "business/orders_filter"

class OrdersFilterUser < OrdersFilter
    def filter
        @user = current_user
        @orders = @user.orders.paginate(page: params[:page])        
    end
end