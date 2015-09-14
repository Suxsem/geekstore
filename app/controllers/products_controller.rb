class ProductsController < ApplicationController
    
  # prevent unauthorized access from non-admin users
  before_action :logged_in_admin, only: [:new, :create, :edit, :update, :destroy]

  # retrieve products
  def index
    
    # instantiate a blank filter
    where = {}
    
    # if category param exist then filter products basing on category name
    selected_category_param = params[:category]
    unless selected_category_param.nil?
      selected_category = Category.find(selected_category_param)
      @current_category = selected_category.name
      where[:category] = selected_category
    end
    @categories = Category.all
    
    # if store param exist then filter products basing on store availability
    selected_store_param = params[:store]
    unless selected_store_param.nil?
      selected_store = Store.find(selected_store_param)
      @current_store = selected_store.place
      where[:stores] = {id: selected_store.id}
    end
    @categories = Category.all
    @stores = Store.all
    
    # if discount param exist then only show products with discount
    selected_discount_param = params[:discount]
    unless selected_discount_param.nil?
      @current_discount = "In offerta"
      where[:discount] = 1..100
    end
    
    # retrieve and filter products
    @products = Product.includes(:stores).where(where).paginate(page: params[:page])
    
  end
  
  # retrieve the selected product and instantiate a blank order with the selected product
  def show
    @product = Product.find(params[:id])
    @order = Order.new(product: @product)
  end
  
  # create a new product
  def new
    @product = Product.new
  end
  
  # validate and save a new product
  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Prodotto aggiunto"
      # redirect to products index
      redirect_to products_path
    else
      # if validataion fails redirect to the new product form
      render 'new'
    end
  end
  
  # retrieve a single product to be edited
  def edit
    @product = Product.find(params[:id])
  end
  
  # validate and update an existing product
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "Prodotto modificato con successo"
      # redirect to products index
      redirect_to products_path
    else
      # if validataion fails redirect to the edit product form
      render 'edit'
    end
  end
  
  # destroy a single product
  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "Prodotto rimosso"
    # redirect to productss index
    redirect_to products_path
  end
  
  private

    # allow only authorized request parameters for product
    def product_params
      params.require(:product).permit(:name, :category_id, :desc, :price, :discount, :image, :image_cache, :store_ids => [])
    end
  
end