require "business/orders_filter_user"
require "business/orders_filter_admin"

class OrdersController < ApplicationController
    
  before_action :logged_in_user, only: [:index, :cart], :unless => :format_json?
  before_action only: [:create] do
    logged_in_user
    store_location product_path(Product.find(params[:order][:product_id]))
  end
  before_action only: [:destroy, :buy] do
    logged_in_user
    store_location cart_path
  end
  before_action :logged_in_admin, only: [:update, :manage]
    
  def cart
    respond_to do |format|
      format.html do    
        @orders = current_user.orders.where(status: Order.possible_status[:wait_payment])
        @total = 0
        @orders.each do |order|
            @total += order.product.final_price
            @total += order.upgrades.sum(:price)
        end
      end
    end
  end
  
  def buy
      orders = current_user.orders.where(status: Order.possible_status[:wait_payment])
      orders.each do |order|
          order.status = Order.possible_status[:wait_confirm]
          order.save
      end
      flash[:success] = "Acquisto completato"
      redirect_to orders_path
  end
  
  def index
    respond_to do |format|
      format.html do
        if admin?
		      orders_filter = OrdersFilterAdmin.new @_request
        else
          orders_filter = OrdersFilterUser.new @_request
        end
        @orders = orders_filter.filter
        @user = User.find(params[:user_id])
      end
      format.json do
        if user = authenticate_with_http_basic { |name, password| User.find_by(name: name).authenticate(password) }
          render json: user.orders
        else
          request_http_basic_authentication
        end
      end
    end
  end
    
  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      flash[:success] = "Prodotto aggiunto al carrello"
      redirect_to cart_path
    else
      flash[:danger] = "Errore interno"
      redirect_to root_path
    end
  end
  
  def manage
    if params[:show_all]
      @orders = Order.all.paginate(page: params[:page])
      @show_all = true
    else
      @orders = Order.where("status != ? AND status != ?", Order.possible_status[:sent], Order.possible_status[:denied]).paginate(page: params[:page])
    end
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      flash[:success] = "Ordine modificato"
      redirect_to manage_path
    else
      flash[:danger] = "Errore interno"
      redirect_to root_path
    end
  end
  
  def destroy
    current_user.orders.find(params[:id]).destroy
    flash[:success] = "Prodotto rimosso dal carrello"
    redirect_to cart_path
  end

  private

    def order_params
      params.require(:order).permit(:product_id, :status, :upgrade_ids => [])
    end

    def format_json?
      request.format.json?
    end

end
