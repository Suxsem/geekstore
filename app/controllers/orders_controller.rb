class OrdersController < ApplicationController
    
  before_action :logged_in_user, only: [:index, :destroy]
  before_action :logged_in_user_add, only: [:create]
  before_action :logged_in_user_cart, only: [:cart, :buy]
  before_action :logged_in_admin, only: [:update, :manage]
    
  def cart
      @orders = current_user.orders.where(status: "in attesa di pagamento")
      @total = 0
      @orders.each do |order|
          @total += order.product.final_price
          @total += order.upgrades.sum(:price)
      end
  end
  
  def buy
      orders = current_user.orders.where(status: "in attesa di pagamento")
      orders.each do |order|
          order.status = "in attesa di conferma"
          order.save
      end
      flash[:success] = "Acquisto completato"
      redirect_to orders_path
  end
  
  def index
    if admin?
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
    @orders = @user.orders.paginate(page: params[:page])
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
  
  def update
    #TODO    
  end
  
  def manage
    #TODO    
  end
  
  def destroy
    current_user.orders.find(params[:id]).destroy
    flash[:success] = "Prodotto rimosso dal carrello"
    redirect_to cart_path
  end

  private

    def user_params
      params.require(:order).permit(:product_id, :upgrade_ids => [])
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
