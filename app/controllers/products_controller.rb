class ProductsController < ApplicationController
    
  before_action :logged_in_admin, only: [:new, :create, :edit, :update, :destroy]
    
  def index
    
    where = {}
    
    selected_category_param = params[:category]
    unless selected_category_param.nil?
      selected_category = Category.find(selected_category_param)
      @current_category = selected_category.name
      where[:category] = selected_category
    end
    @categories = Category.all
    
    selected_store_param = params[:store]
    unless selected_store_param.nil?
      selected_store = Store.find(selected_store_param)
      @current_store = selected_store.place
      where[:stores] = {id: selected_store.id}
    end
    @categories = Category.all
    @stores = Store.all
    
    selected_discount_param = params[:discount]
    unless selected_discount_param.nil?
      @current_discount = "In offerta"
      where[:discount] = 1..100
    end
        
    @products = Product.includes(:stores).where(where).paginate(page: params[:page])
    
  end
  
  def show
    @product = Product.find(params[:id])
    @order = Order.new(product: @product)
  end
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Prodotto aggiunto"
      redirect_to products_path
    else
      render 'new'
    end
  end
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "Prodotto modificato con successo"
      redirect_to products_path
    else
      render 'edit'
    end
  end
  
  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "Prodotto rimosso"
    redirect_to products_path
  end
  
  private

    def product_params
      params.require(:product).permit(:name, :category_id, :desc, :price, :discount, :image, :image_cache, :store_ids => [])
    end
  
end