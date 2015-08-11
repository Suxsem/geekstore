class CategoriesController < ApplicationController
    
  before_action :logged_in_admin
  
  def index
    @categories = Category.paginate(page: params[:page])
  end
    
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Categoria aggiunta"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Categoria modificata con successo"
      redirect_to categories_path
    else
      render 'edit'
    end
  end
  
  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Categoria rimossa"
    redirect_to categories_path
  end
    
  private

    def category_params
      params.require(:category).permit(:name)
    end
    
end
