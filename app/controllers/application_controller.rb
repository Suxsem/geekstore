# all controllers inherit from this class

class ApplicationController < ActionController::Base
  
  # prevent CSRF attacks by raising an exception.
  
  protect_from_forgery with: :exception
  
  # include SessionsHelper helper to protect pages from unauthorized access
  
  include SessionsHelper

  private
  
    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        # store current location to automatically redirect user after login
        store_location
        # show a flash message on the page
        flash[:danger] = "Per favore effettua il login"
        # redirect user to login page
        redirect_to login_url
      end
    end
    
    # Confirms a logged-in admin.
    def logged_in_admin
      unless admin?
        # show a flash message on the page
        flash[:danger] = "Non sei autorizzato a visitare questa pagina"
        # redirect user to home page
        redirect_to root_path
      end
    end
    
end