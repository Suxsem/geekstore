class UpgradesController < ApplicationController
  
  # prevent unauthorized access from non-admin users
  before_action :logged_in_admin
  
  # retrieve all upgrades of the selected product
  def index
    @product = Product.find(params[:product_id])
    @upgrades = @product.upgrades.paginate(page: params[:page])
  end
  
  # create a new upgrade for the selected product
  def new
    @upgrade = Product.find(params[:product_id]).upgrades.new
  end
  
  # validate and save a new upgrade
  def create
    @upgrade = Upgrade.new(upgrade_params)
    if @upgrade.save
      flash[:success] = "Potenziamento aggiunto"
      # redirect to upgrades index
      redirect_to upgrades_path(product_id: @upgrade.product.id)
    else
      # if validataion fails redirect to the new upgrade form
      render 'new'
    end
  end
  
  # retrieve a single upgrade to be edited
  def edit
    @upgrade = Upgrade.find(params[:id])
  end
  
  # validate and update an existing upgrade
  def update
    @upgrade = Upgrade.find(params[:id])
    if @upgrade.update_attributes(upgrade_params)
      flash[:success] = "Potenziamento modificato con successo"
      # redirect to upgrades index for the selected product
      redirect_to upgrades_path(product_id: @upgrade.product.id)
    else
      # if validataion fails redirect to the edit upgrade form
      render 'edit'
    end
  end  
  
  # destroy a single upgrade
  def destroy
    upgrade = Upgrade.find(params[:id])
    product_id = upgrade.product.id
    upgrade.destroy
    flash[:success] = "Potenziamento rimosso"
    # redirect to upgrades index for the selected product
    redirect_to upgrades_path(product_id: product_id)
  end
  
  private

    # allow only authorized request parameters for upgrade
    def upgrade_params
      params.require(:upgrade).permit(:name, :product_id, :price)
    end
  
end
