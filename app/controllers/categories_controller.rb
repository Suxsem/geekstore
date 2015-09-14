class CategoriesController < ApplicationController

  # prevent unauthorized access from non-admin users
  before_action :logged_in_admin
  
  # retrieve all categories
  def index
    @categories = Category.paginate(page: params[:page])
  end
    
  # create a new category
  def new
    @category = Category.new
  end
  
  # validate and save a new category
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Categoria aggiunta"
      # redirect to categories index
      redirect_to categories_path
    else
      # if validataion fails redirect to the new category form
      render 'new'
    end
  end

  # retrieve a single category to be edited  
  def edit
    @category = Category.find(params[:id])
  end

  # validate and update an existing category
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Categoria modificata con successo"
      # redirect to categories index
      redirect_to categories_path
    else
      # if validataion fails redirect to the edit category form      
      render 'edit'
    end
  end
  
  # destroy a single category
  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Categoria rimossa"
    # redirect to categories index      
    redirect_to categories_path
  end
    
  private

    # allow only authorized request parameters for category
    def category_params
      params.require(:category).permit(:name)
    end
    
end
