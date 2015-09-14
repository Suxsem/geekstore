class StoresController < ApplicationController
    
    # retrieve all stores
    def index
        @stores = Store.all
        respond_to do |format|
            format.html { @stores = @stores.page(params[:page]) }
            # don't paginate stores if the request is a json request
            format.json { render json: @stores }
        end
    end
    
    # retrieve a single store
    def show
        @store = Store.find(params[:id])
        respond_to do |format|
            format.html
            format.json { render json: @store }
        end
    end
end
