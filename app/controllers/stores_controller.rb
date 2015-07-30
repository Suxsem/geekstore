class StoresController < ApplicationController
    def index
        @stores = Store.all
        respond_to do |format|
            format.html { @stores = @stores.page(params[:page]) }
            format.json { render json: @stores }
        end
    end
    
    def show
        @store = Store.find(params[:id])
        respond_to do |format|
            format.html
            format.json { render json: @store }
        end
    end
end
