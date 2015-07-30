class UpgradesController < ApplicationController
  
  before_action :logged_in_admin
    
  def index
    @product = Product.find(params[:product_id])
    @upgrades = @product.upgrades.paginate(page: params[:page])
  end
  
  def new
    @upgrade = Product.find(params[:product_id]).upgrades.new
  end
  
  def create
    @upgrade = Upgrade.new(user_params)
    if @upgrade.save
      flash[:success] = "Potenziamento aggiunto"
      redirect_to upgrades_path(product_id: @upgrade.product.id)
    else
      render 'new'
    end
  end
  
  def edit
    @upgrade = Upgrade.find(params[:id])
  end
  
  def update
    @upgrade = Upgrade.find(params[:id])
    if @upgrade.update_attributes(user_params)
      flash[:success] = "Potenziamento modificato con successo"
      redirect_to upgrades_path(product_id: @upgrade.product.id)
    else
      render 'edit'
    end
  end  
  
  def destroy
    upgrade = Upgrade.find(params[:id])
    product_id = upgrade.product.id
    upgrade.destroy
    flash[:success] = "Potenziamento rimosso"
    redirect_to upgrades_path(product_id: product_id)
  end
  
  private

    def user_params
      params.require(:upgrade).permit(:name, :product_id, :price)
    end
    
    # Before filters
    
    # Confirms a logged-in admin.
    def logged_in_admin
      unless admin?
        flash[:danger] = "Non sei autorizzato a visitare questa pagina"
        redirect_to root_path
      end
    end
  
end
