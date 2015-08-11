class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  
    # Before filters

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
