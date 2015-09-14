require "business/orders_filter"

class OrdersFilterAdmin < OrdersFilter
    
    # retrieve all orders of the selected users
    def filter
        @user = User.find(params[:user_id])
        @orders = @user.orders.paginate(page: params[:page])
    end
end