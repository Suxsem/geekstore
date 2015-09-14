require "business/orders_filter_user"
require "business/orders_filter_admin"

class OrdersController < ApplicationController

  # ensure that only a logged user can access orders list and cart
  # =>  (exclude json format because it manages the authentication in a different way)
  before_action :logged_in_user, only: [:index, :cart], :unless => :format_json?
  # ensure that only a logged user can create a new orders
  before_action only: [:create] do
    logged_in_user
    # store current product location to redirect the user after login
    store_location product_path(Product.find(params[:order][:product_id]))
  end
  # ensure that only a logged user can pay or destroy an existing order
  before_action only: [:destroy, :buy] do
    logged_in_user
    # store cart location to redirect the user after login    
    store_location cart_path
  end
  # ensure that only an admin can browse all orders and update them
  before_action :logged_in_admin, only: [:update, :manage]
  
  # retrieve all orders (not yet paid) in the cart
  def cart
    # repond only to html requests to avoid json attacks
    respond_to do |format|
      format.html do
        @orders = current_user.orders.where(status: Order.possible_status[:wait_payment])
        # compute the cart total price
        @total = 0
        @orders.each do |order|
            @total += order.product.final_price
            @total += order.upgrades.sum(:price)
        end
      end
    end
  end
  
  # marks all orders in the cart as paid
  def buy
      orders = current_user.orders.where(status: Order.possible_status[:wait_payment])
      orders.each do |order|
          order.status = Order.possible_status[:wait_confirm]
          order.save
      end
      flash[:success] = "Acquisto completato"
      # redirect to orders history page
      redirect_to orders_path
  end
  
  # retrieve all orders
  def index
    respond_to do |format|
      # if the request is an html request then behave normally
      format.html do
        # if the current user is an admin, retrieve orders basing on the user_id param of the request
        # =>  use the strategy pattern to handle different filtering tecniquies
        if admin?
		      orders_filter = OrdersFilterAdmin.new @_request
		      @user = User.find(params[:user_id])
        else
          orders_filter = OrdersFilterUser.new @_request
        end
        @orders = orders_filter.filter
      end
      # if the request is a json request then use the basic auth protocol to identify the user
      format.json do
        if user = authenticate_with_http_basic do |name, password|
              user = User.find_by(name: name.downcase)
              if user.nil?
                false
              else
                user.authenticate(password)
              end
            end
          # use the rails integrated json renderer to export orders
          render json: user.orders.to_json(include: [:upgrades, :product])
        else
          # if the authentication fails, ask credentials again
          request_http_basic_authentication
        end
      end
    end
  end
    
  # validate and save a new (unpaid) order
  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      flash[:success] = "Prodotto aggiunto al carrello"
      # redirect to cart to let the user pay
      redirect_to cart_path
    else
      # if validataion fails redirect to the home page
      flash[:danger] = "Errore interno"
      redirect_to root_path
    end
  end
  
  # retrieve all orders of all users (admin only)
  def manage
    # choose to don't display concluded orders or not basing on the show_all request parameter
    if params[:show_all]
      @orders = Order.all.paginate(page: params[:page])
      @show_all = true
    else
      @orders = Order.where("status != ? AND status != ?", Order.possible_status[:sent], Order.possible_status[:denied]).paginate(page: params[:page])
    end
  end
  
  # validate and update an existing order (admin only)
  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      flash[:success] = "Ordine modificato"
      # redirect to orders managing page
      redirect_to manage_path
    else
      # if validataion fails redirect to the home page
      flash[:danger] = "Errore interno"
      redirect_to root_path
    end
  end
  
  # destroy a single (unpaid) order
  def destroy
    current_user.orders.find(params[:id]).destroy
    flash[:success] = "Prodotto rimosso dal carrello"
    # redirect to cart
    redirect_to cart_path
  end

  private

    # allow only authorized request parameters for order
    def order_params
      params.require(:order).permit(:product_id, :status, :upgrade_ids => [])
    end

    # determine if the client request is a json request
    def format_json?
      request.format.json?
    end

end
