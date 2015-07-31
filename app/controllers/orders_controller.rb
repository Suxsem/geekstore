class OrdersController < ApplicationController
    
  before_action :logged_in_user, only: [:index, :destroy]
  before_action :logged_in_user_add, only: [:create]
  before_action :logged_in_user_cart, only: [:cart, :buy]
  before_action :logged_in_admin, only: [:update, :manage]
    
  def cart
      @orders = current_user.orders.where(status: Order.possible_status[:wait_payment])
      @total = 0
      @orders.each do |order|
          @total += order.product.final_price
          @total += order.upgrades.sum(:price)
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
          @user = User.find(params[:user_id])
        else
          @user = current_user
        end
        @orders = @user.orders.paginate(page: params[:page])
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
    @order = current_user.orders.build(user_params)
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
    if @order.update_attributes(user_params)
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

    def user_params
      params.require(:order).permit(:product_id, :status, :upgrade_ids => [])
    end
        
    # Before filters

    # Confirms a logged-in user before new order.
    def logged_in_user_add
      unless logged_in?
        store_this_location product_path(Product.find(params[:order][:product_id]))
        flash[:danger] = "Per favore effettua il login"
        redirect_to login_url
      end
    end
    
    # Confirms a logged-in user before interacting with the cart.
    def logged_in_user_cart
      unless logged_in?
        store_this_location cart_path
        flash[:danger] = "Per favore effettua il login"
        redirect_to login_url
      end
    end    
    
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Per favore effettua il login"
        redirect_to login_url
      end
    end
    
    # Confirms a logged-in admin.
    def logged_in_admin
      unless admin?
        flash[:danger] = "Non sei autorizzato a visitare questa pagina"
        redirect_to root_path
      end
    end    
    
end
